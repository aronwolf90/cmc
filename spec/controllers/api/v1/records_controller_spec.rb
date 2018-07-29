# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::RecordsController, type: :controller do
  let(:model) { build_stubbed(:record) }

  include_examples "standard create action",
    Api::V1::Records::CreateOperation
  include_examples "standard update action",
    Api::V1::Records::UpdateOperation
end
