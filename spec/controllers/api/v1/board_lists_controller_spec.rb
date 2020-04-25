# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::BoardListsController, type: :controller do
  let(:model) { BoardList.new(id: 1) }

  before do
    allow(Api::V1::BoardLists::ShowQuery).to receive(:call).and_return(model)
  end

  include_examples "standard api show action"
  include_examples "standard api update action",
                   Api::V1::BoardLists::UpdateOperation
  include_examples "standard api destroy action"

  before { sign_in(Admin.new) }

  it "GET index" do
    controller.collection_query = double

    expect(controller.collection_query).to receive(:call).and_return([])

    get :index
  end
end
