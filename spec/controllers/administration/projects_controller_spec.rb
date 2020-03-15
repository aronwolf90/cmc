# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::ProjectsController, type: :controller do
  let(:model) { Project.new(id: 1) }
  let(:form) { Administration::ProjectForm }
  let(:params) { {} }

  before { allow(Project).to receive(:find) }

  include_examples "standard index action", Administration::Projects
  include_examples "basic show action",
                   params: { id: 1 }
end
