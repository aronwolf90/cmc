# frozen_string_literal: true

require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe "#create_or_update" do
    context "when the id is not present" do
      it "send post request" do
        expect(RestClient).to receive(:post).with(
          "http://payment:4000/api/v1/subscriptions",
          {
            data: {
              attributes: {
                stripe_session_id: "cs_test_8fh4AlX39Nc",
                organization_id: "1",
                email: "test@example.com",
                quantity: 1
              }
            }
          },
          {
            "Authorization": "Basic YWRtaW46dGVzdHRlc3Q=",
            "Content-Type": "application/json"
          }
        ).and_return(
          instance_double(
            RestClient::Response,
            body: {
              data: {
                id: 1,
                type: "subscriptions",
                attributes: {
                  stripeSessionId: "cs_test_8fh4AlX39Nc",
                  organizationId: 1,
                  email: "test@example.com",
                  quantity: 1
                }
              }
            }.to_json
          )
        )
        subscription = described_class.create_or_update(
          stripe_session_id: "cs_test_8fh4AlX39Nc",
          organization_id: "1",
          email: "test@example.com",
          quantity: 1
        )
        expect(subscription.id).to eq(1)
      end
    end

    context "when the id is not present" do
      it "send post request" do
        expect(RestClient).to receive(:patch).with(
          "http://payment:4000/api/v1/subscriptions/1",
          {
            data: {
              attributes: {
                stripe_session_id: "cs_test_8fh4AlX39Nc",
                organization_id: "1",
                email: "test@example.com",
                quantity: 1
              }
            }
          },
          {
            "Authorization": "Basic YWRtaW46dGVzdHRlc3Q=",
            "Content-Type": "application/json"
          }
        ).and_return(
          instance_double(
            RestClient::Response,
            body: {
              data: {
                id: 1,
                type: "subscriptions",
                attributes: {
                  stripeSessionId: "cs_test_8fh4AlX39Nc",
                  organizationId: 1,
                  email: "test@example.com",
                  quantity: 1
                }
              }
            }.to_json
          )
        )
        subscription = described_class.create_or_update(
          id: 1,
          stripe_session_id: "cs_test_8fh4AlX39Nc",
          organization_id: "1",
          email: "test@example.com",
          quantity: 1
        )
        expect(subscription.id).to eq(1)
      end
    end
  end
end
