# frozen_string_literal: true

require "rails_helper"

RSpec.describe Organization, type: :model do
  context "when already a organization with the same name exists" do
    before { create(:organization, name: "test") }

    it "creating a new one raise an error" do
      expect do
        create(:organization, name: "test")
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe "#to_s" do
    subject { Organization.new(name: "test").to_s }

    it "returns the name" do
      is_expected.to eq "test"
    end
  end

  describe "#subscription" do
    it "when the susbcription exist then it is returned" do
      expect(RestClient).to receive(:get).with(
        "http://payment:4000/api/v1/organizations/1/subscription",
        "Authorization": "Basic YWRtaW46dGVzdHRlc3Q=",
        "Content-Type": "application/json"
      ).and_return(
        instance_double(
          RestClient::Response,
          body: {
            data: {
              id: 1,
              type: "subscriptions",
              attributes: {
                "stripeSessionId": "cs_test_xpK6Pq8jMXbcxlV41ESuACxwqEosAGNM52zTSiqsp7PO1TnuJ23vCUPM",
                "organizationId": 1,
                "quantity": 1,
                "ibanLast4": "4242",
                "email": "test@example.com",
                "premia": 0
              }
            }
          }.to_json
        )
      )
      expect(described_class.new(id: 1).subscription)
        .to eq(Subscription.new(
                 id: 1,
                 stripe_session_id: "cs_test_xpK6Pq8jMXbcxlV41ESuACxwqEosAGNM52zTSiqsp7PO1TnuJ23vCUPM",
                 organization_id: 1,
                 quantity: 1,
                 iban_last4: "4242",
                 email: "test@example.com",
                 premia: 0
        ))
    end

    it "when the susbcription does not exist then it is not returned" do
      expect(RestClient).to receive(:get).with(
        "http://payment:4000/api/v1/organizations/1/subscription",
        "Authorization": "Basic YWRtaW46dGVzdHRlc3Q=",
        "Content-Type": "application/json"
      ).and_raise(RestClient::NotFound)
      expect(described_class.new(id: 1).subscription).to be_nil
    end
  end

  describe "#invoices" do
    it "return invoices if subscription_id!=nil" do
      expect(RestClient).to receive(:get).with(
        "http://payment:4000/api/v1/organizations/1/invoices",
        "Authorization": "Basic YWRtaW46dGVzdHRlc3Q=",
        "Content-Type": "application/json"
      ).and_return(
        instance_double(
          RestClient::Response,
          body: {
            data: [{
              id: "invoice_id",
              type: "invoices",
              attributes: {
                createdAt: "2019-11-06T19:59:10Z",
                amountDue: 2,
                amountPaid: 2,
                amountRemaining: 0,
                pdf: "https://pay.stripe.com/invoice/invst_9KtFtihugeF8KkYEfFEJltHcg7/pdf"
              }
            }]
          }.to_json
        )
      )
      expect(described_class.new(id: 1).invoices)
        .to eq([Invoice.new(
          id: "invoice_id",
          created_at: "2019-11-06T19:59:10Z",
          amount_due: 2,
          amount_paid: 2,
          amount_remaining: 0,
          pdf: "https://pay.stripe.com/invoice/invst_9KtFtihugeF8KkYEfFEJltHcg7/pdf"
        )])
    end

    it "when a not found is raised" do
      expect(RestClient).to receive(:get).with(
        "http://payment:4000/api/v1/organizations/1/invoices",
        "Authorization": "Basic YWRtaW46dGVzdHRlc3Q=",
        "Content-Type": "application/json"
      ).and_raise(RestClient::NotFound)

      expect(described_class.new(id: 1).invoices)
        .to eq([])
    end
  end

  describe "#premium?" do
    it "return true when subscription_id is present" do
      expect(described_class.new(subscription_id: 1).premium?).to eq true
    end

    it "return true when subscription_id is present" do
      expect(described_class.new(subscription_id: nil).premium?).to eq false
    end
  end

  describe ".premium?" do
    it "return true when .current is nil" do
      allow(Settings).to receive(:multi_tenant).and_return false
      allow(described_class).to receive(:current).and_return(nil)
      expect(described_class.premium?).to eq true
    end

    it "return true when #premium? return true" do
      allow(Settings).to receive(:multi_tenant).and_return true
      allow(described_class).to receive(:current).and_return(instance_double(described_class, premium?: true))
      expect(described_class.premium?).to eq true
    end

    it "return false when #premium? is false" do
      allow(Settings).to receive(:multi_tenant).and_return true
      allow(described_class).to receive(:current).and_return(instance_double(described_class, premium?: false))
      expect(described_class.premium?).to eq false
    end
  end

  describe "#google_calender_authorization_data" do
    subject(:google_calender_authorization_data) do
      described_class.new(
        google_calender_access_token: "access_token",
        google_calender_expires_at: DateTime.parse("10.10.2020 10:10:00"),
        google_calender_refresh_token: "refresh_token"
      ).google_calender_authorization_data
    end

    specify do
      expect(google_calender_authorization_data).to eq(
        GoogleAuthorizationData.new(
          access_token: "access_token",
          expires_at: DateTime.parse("10.10.2020 10:10:00"),
          refresh_token: "refresh_token"
        )
      )
    end
  end

  describe "#google_calender_authorization_data=" do
    subject(:organization) { Organization.new }

    let(:google_calender_authorization_data) do
      GoogleAuthorizationData.new(
        access_token: "access_token",
        expires_at: DateTime.parse("10.10.2020 10:10:00"),
        refresh_token: "refresh_token"
      )
    end

    specify do
      organization.google_calender_authorization_data =
        google_calender_authorization_data

      expect(organization).to have_attributes(
        google_calender_access_token: "access_token",
        google_calender_expires_at: DateTime.parse("10.10.2020 10:10:00").in_time_zone,
        google_calender_refresh_token: "refresh_token"
      )
    end
  end
end
