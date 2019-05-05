# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::BoardListsController, type: :controller do
  let(:model) { BoardList.new(id: 1) }

  describe "GET index" do
    context "when the start_day is present" do
    end

    context "when the start_day is not present" do
    end
  end
end
