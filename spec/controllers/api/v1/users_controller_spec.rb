# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:model) { User.new(id: 1) }

  include_examples "standard api index action"
  include_examples "standard api show action"
  include_examples "standard api create action",
                   Api::V1::Users::CreateOperation
  include_examples "standard api update action",
                   Api::V1::Users::UpdateOperation

  describe "#destroy" do
    it "pass collection to render" do
      sign_in Admin.new
      expect(Api::V1::Users::DestroyOperation)
        .to receive(:call)
      delete :destroy, params: { id: model.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
