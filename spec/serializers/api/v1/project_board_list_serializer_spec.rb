# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectBoardListSerializer, type: :serializer do
  let(:project_board_list) do
    ProjectBoardList.new(
      id: 1,
      name: "New"
    )
  end
  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "project-board-lists",
        attributes: {
          name: "New"
        },
        relationships: {
          projects: {
            data: []
          }
        },
        links: { self: "/api/v1/project_board_lists/1" }
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(project_board_list)).to eql expected_result
  end
end
