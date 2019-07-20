# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Projects::DashboardsController, type: :controller do
  before { allow(Project).to receive(:find) }

  include_examples "basic show action",
                   params: { project_id: 1 }
end
