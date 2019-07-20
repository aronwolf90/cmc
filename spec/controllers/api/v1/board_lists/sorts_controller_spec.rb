# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Api::V1::BoardLists::SortsController do
  include_examples "simple api update action",
                   Api::V1::BoardLists::Sort::UpdateOperation,
                   params: {
                     "data" => %w[1 2],
                     "controller" => "api/v1/board_lists/sorts",
                     "action" => "update"
                   }
end
