# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Calendars::GoogleIntegrationsController, type: :controller do
  let(:current_user) { Admin.new }
  let(:organization) { Organization.new }

  before do
    sign_in(current_user)
    allow(Organization).to receive(:current).and_return(organization)
    expect(Api::V1::Calendars::GoogleIntegrations::DestroyOperation)
      .to receive(:call)
      .with(current_user: current_user, params: {}, organization: organization)
      .and_return(result)
  end

  describe "DELETE destroy" do
    subject(:make_destroy_request) { delete :destroy }

    context "when the operation was succefully" do
      let(:result) do
        Trailblazer::Operation::Result.new(true, "result.policy.default" => double(failure?: false))
      end

      specify do
        make_destroy_request

        expect(response).to have_http_status(:ok)
      end
    end

    context "when the policy fails" do
      let(:result) do
        Trailblazer::Operation::Result.new(false, "result.policy.default" => double(failure?: true))
      end

      specify do
        make_destroy_request

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when the operation fails for some other reason" do
      let(:result) do
        Trailblazer::Operation::Result.new(false, "result.policy.default" => double(failure?: false))
      end

      specify do
        make_destroy_request

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
