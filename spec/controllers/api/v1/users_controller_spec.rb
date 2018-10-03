# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:model) { User.new(id: 1) }

  include_examples "standard api index action"
  include_examples "standard api update action",
    Api::V1::Users::UpdateOperation
end
