# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Users::DestroyOperation do
  subject do
    described_class.(
      params: { user_id: user.id },
      current_user: current_user
    )
  end
  let(:user) { User.new(id: 1) }
  let(:current_user) { Admin.new }

  before { allow(User).to receive(:find).and_return(user) }

  it "destroy the user" do
    expect(::Users::DestroyMutation)
      .to receive(:call)
      .with(model: user, current_user: current_user)
    subject
  end

  it "call Subscription#update when a subscription exists" do
    subscription = Subscription.new
    allow(Organization)
      .to receive(:subscription).and_return(subscription)
    allow(User).to receive(:count).and_return(1)
    expect(subscription).to receive(:update).with(
      quantity: 1
    )
    subject
  end

  it "not raise an exception when no subscription exists" do
    allow(Organization)
      .to receive(:subscription).and_return(nil)
    expect { subject }.not_to raise_error
  end
end
