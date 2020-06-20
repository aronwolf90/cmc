# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Admin::Payments::IndexOperation do
  subject do
    described_class.(params: params, current_user: current_user)
  end

  let(:current_user) { Admin.new(email: "test@example.com") }
  let(:organization) { Organization.new(id: 1) }
  let(:subscription) { Subscription.new(id: 1) }

  before do
    allow(Organization).to receive(:current).and_return(organization)
    allow(Admin).to receive(:first).and_return(current_user)
    allow(Subscription).to receive(:create_or_update).and_return(subscription)
    allow(User).to receive(:count).and_return(1)
  end

  context "when the params are empty" do
    let(:params) { {} }

    it "not Subscription.create" do
      subject
      expect(Subscription).not_to have_received(:create_or_update)
    end
  end

  context "when stripe_session_id is in the params and Organization#subscription=nil" do
    let(:params) { { stripe_session_id: "test_id" } }

    before do
      allow(organization).to receive(:subscription).and_return(nil)
    end

    it "call Subscription.create" do
      expect(subject[:model]).to be_a Subscription
      expect(Subscription).to have_received(:create_or_update).with(
        id: nil,
        stripe_session_id: "test_id",
        organization_id: 1,
        email: "test@example.com",
        quantity: 1
      )
    end
  end

  context "when stripe_session_id is in the params and Organization#subscription!=nil" do
    let(:params) { { stripe_session_id: "test_id" } }
    let(:organization) { Organization.new(id: 1, subscription_id: 1) }

    before do
      allow(organization).to receive(:subscription).and_return(subscription)
    end

    it "call Subscription.create" do
      expect(subject[:model]).to be_a Subscription
      expect(Subscription).to have_received(:create_or_update).with(
        id: 1,
        stripe_session_id: "test_id",
        organization_id: 1,
        email: "test@example.com",
        quantity: 1
      )
    end
  end
end
