# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Projects::RemindersController, type: :controller do
  let(:model) { BoardList.new(id: 1) }

  before { sign_in(Admin.new) }

  it "get index" do
    controller.collection_query = double

    expect(controller.collection_query).to receive(:call)
      .and_return(OpenStruct.new(collection: []))

    get :index, params: { project_id: 1 }
  end
end
