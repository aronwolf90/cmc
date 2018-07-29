# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:model) { build_stubbed(:user) }

  include_examples "standard index action"
  include_examples "standard update action",
    Api::V1::Users::UpdateOperation
end
