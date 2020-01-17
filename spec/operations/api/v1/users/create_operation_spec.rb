# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::Users::CreateOperation do
  include_examples "standard api create operation",
                   form: Api::V1::Users::CreateForm,
                   deserializer: Api::V1::UserDeserializer do
    context "when params are valid" do
      let(:form_result) { OpenStruct.new(errors: []) }
      let(:params) { {} }
      let(:result) { double(errors: []) }

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
  end
end
