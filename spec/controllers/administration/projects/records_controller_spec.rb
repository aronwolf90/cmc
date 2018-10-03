# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Projects::RecordsController, type: :controller do
  let(:params) { { project_id: 1 } }
  let(:project) { Project.new(id: 1) }

  before { allow(Project).to receive(:find).and_return(project) }

  include_examples "standard index action", Administration::Projects::Records
end
