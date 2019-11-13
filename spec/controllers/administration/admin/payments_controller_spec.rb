# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Admin::PaymentsController, type: :controller do
  let(:user) { Admin.new }
  let(:params) { { stripe_session_id: "stripe_session_id" }  }

  include_examples "standard index action", Administration::Admin::Payments

  context "when operation retuns a model" do
    it "flass message is set" do
      allow(Administration::Admin::Payments::IndexOperation)
        .to receive(:call).and_return(double("[]" => Subscription.new, success?: true))
      sign_in user
      get :index, params: params
      expect(request.flash[:success]).to eq("You have successfully added you payment information")
    end
  end
end
