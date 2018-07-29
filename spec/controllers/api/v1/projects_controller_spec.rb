# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::ProjectsController, type: :controller do
  let(:model) { build_stubbed(:project) }

  include_examples "standard index action"
end
