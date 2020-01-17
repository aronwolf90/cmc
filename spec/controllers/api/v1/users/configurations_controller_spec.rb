# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Api::V1::Users::ConfigurationsController, type: :controller do
  let(:model) { User.new(id: 1) }

  include_examples "standard api update action",
                   Api::V1::Users::Configuration::UpdateOperation do
    subject { put :update, params: { user_id: model.id } }
    let(:params) do
      {
        "user_id" => model.id.to_s,
        "controller" => "api/v1/users/configurations",
        "action" => "update"
      }
    end
  end
end
