# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::BoardListsController, type: :controller do
  let(:model) { build_stubbed(:board_list) }
  let(:form) { Administration::BoardListForm }
  let(:params) { {} }

  include_examples "standard new action", Administration::BoardLists
  include_examples "standard create action", Administration::BoardLists,
    %i[administration board]
  include_examples "standard edit action", Administration::BoardLists
  include_examples "standard update action", Administration::BoardLists,
    %i[administration board]
  include_examples "standard destroy action", Administration::BoardLists,
    %i[administration board]
end
