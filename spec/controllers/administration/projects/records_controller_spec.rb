# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Projects::RecordsController, type: :controller do
  let(:params) { { project_id: 1 } }
  let(:project) { build_stubbed(:project) }

  before { allow(Project).to receive(:find).and_return(project) }

  include_examples "standard index action", Administration::ProjectRecords
end
