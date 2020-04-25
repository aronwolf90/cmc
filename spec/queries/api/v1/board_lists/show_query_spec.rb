# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardLists::ShowQuery do
  subject { described_class.call(id: board_list.id, project_id: project.id) }

  let!(:project) { create(:project) }
  let!(:board_list) { create(:board_list, project: project) }

  it "return the board_list correct order for the specified project" do
    expect(subject).to eq(board_list)
  end
end
