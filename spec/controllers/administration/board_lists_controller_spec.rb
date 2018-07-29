# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Administration::BoardListsController, type: :controller do
  let(:model) { build_stubbed(:record) }
  let(:form) { Administration::BaordListsForm }
  let(:params) { {} }

  include_examples "standart new action", Administration::BoardLists
  include_examples "standart create action", Administration::BoardLists,
    %i[administration board]
  include_examples "standart edit action", Administration::BoardLists
  include_examples "standart update action", Administration::BoardLists,
    %i[administration board]
  include_examples "standart destroy action", Administration::BoardLists,
    %i[administration board]
end
