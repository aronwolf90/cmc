# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Administration::ProjectsController, type: :controller do
  let(:model) { build_stubbed(:project) }
  let(:params) { {} }

  include_examples "standart index action", Administration::Projects
  include_examples "standart new action", Administration::Projects
  include_examples "standart edit action", Administration::Projects
  include_examples "standart create action", Administration::Projects
  include_examples "standart update action", Administration::Projects,
    %i[administration projects]
  include_examples "standart destroy action", Administration::Projects,
    %i[administration projects]
end
