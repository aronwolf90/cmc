# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::LabelsController, type: :controller do
  let(:model) { Record.new(id: 1) }

  include_examples "standard api create action",
                   Api::V1::Labels::CreateOperation
end
