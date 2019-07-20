# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::ProjectsController, type: :controller do
  let(:model) { Project.new(id: 1) }
  let(:form) { Administration::ProjectForm }
  let(:params) { {} }

  include_examples "standard index action", Administration::Projects
  include_examples "standard new action", Administration::Projects
  include_examples "standard edit action", Administration::Projects
  include_examples "standard create action", Administration::Projects
  include_examples "standard update action", Administration::Projects,
                   %i[administration projects]
  include_examples "standard destroy action", Administration::Projects,
                   %i[administration projects]
end
