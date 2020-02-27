# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::TestOrganizationsController, type: :controller do
  let(:model) { Organization.new(id: 1) }

  include_examples "standard api create action",
                   Api::V1::TestOrganizations::CreateOperation

  describe "DESTROY /api/v1/test_organizations" do
    it "calls operation" do
      controller.destroy_operation = double
      expect(controller.destroy_operation).to receive(:call)

      delete :destroy
    end

    it "returns status ok" do
      controller.destroy_operation = double
      allow(controller.destroy_operation).to receive(:call)

      delete :destroy

      expect(response).to have_http_status(:ok)
    end
  end
end
