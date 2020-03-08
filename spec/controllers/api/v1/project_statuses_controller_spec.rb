# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::ProjectStatusesController, type: :controller do
  let(:model) { ProjectStatus.new(id: 1) }

  include_examples "standard api index action"
end
