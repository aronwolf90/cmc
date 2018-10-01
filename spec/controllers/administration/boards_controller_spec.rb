# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::BoardsController, type: :controller do
  include_examples "basic show action",
    Administration::Board::Cell::Show
end
