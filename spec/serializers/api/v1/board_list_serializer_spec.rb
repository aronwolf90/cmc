# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardListSerializer, type: :serializer do
  let(:issue) { create(:issue, id: 1) }
  let(:project) { create(:project) }
  let(:board_list) { create(:board_list, issues: [issue], project: project, id: 1) }

  let(:expected_result) do
    {
      data: {
        id: board_list.id.to_s,
        type: "board-lists",
        attributes: {
          name: "name"
        },
        relationships: {
          issues: {
            data: [{ id: "1", type: "issues" }],
            links: {
              self: "/api/v1/board_lists/1/issues"
            }
          },
          project: { data: { id: project.id.to_s, type: "projects" } },
        },
        links: { self: "/api/v1/board_lists/1" }
      }
    }
  end

  it "serialize in the correct way" do
    expect(serialize(board_list)).to eq expected_result
  end
end
