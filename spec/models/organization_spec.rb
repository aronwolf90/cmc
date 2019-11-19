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

  describe "#invoices" do
    it "return invoices if subscription_id!=nil" do
      expect(RestClient).to receive(:get).with(
        "http://payment:4000/api/v1/subscriptions/1/invoices",
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
                amountRemaining: 0
              }
            }]
          }.to_json
        )
      )
      expect(described_class.new(subscription_id: 1).invoices)
        .to eq([Invoice.new(
          id: "invoice_id",
          created_at: "2019-11-06T19:59:10Z",
          amount_due: 2,
          amount_paid: 2,
          amount_remaining: 0
        )])
    end
    it "return invoices if subscription_id==nil" do
      expect(described_class.new(subscription_id: nil).invoices)
        .to eq([])
    end
  end
end
