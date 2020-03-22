# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Api::V1::ProjectBoardLists::ProjectsController, type: :controller do
  before { sign_in(Admin.new) }

  it "#index" do
    collection_query = double
    controller.collection_query = collection_query

    expect(collection_query)
      .to receive(:call)
      .with(more_id: nil, project_board_list_id: "1", per_page: 15)
      .and_return(OpenStruct.new(collection: [Project.new(id: 1)], has_more: false))

    get :index, params: { project_board_list_id: 1 }
  end
end
