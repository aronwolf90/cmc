# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::IssuesController, type: :controller do
  let(:model) { build_stubbed(:issue) }

  include_examples "standard index action"
  include_examples "standard show action"
  include_examples "standard update action",
    Api::V1::Issues::UpdateOperation
  include_examples "standard destroy action"
end
