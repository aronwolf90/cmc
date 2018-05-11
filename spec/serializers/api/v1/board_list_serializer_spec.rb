# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardListSerializer, type: :serializer do
  let(:issue) { build_stubbed(:issue) }
  let(:project) { build_stubbed(:project) }
  let(:board_list) { build_stubbed(:board_list, issues: [issue], project: project) }

  let(:expected_result) do
    {
      data: {
        id: board_list.id.to_s,
        type: "board-lists",
        attributes: {
          name: "name"
        },
        relationships: {
          issues: { data: [{ id: issue.id.to_s, type: "issues" }] },
          project: { data: { id: project.id.to_s, type: "projects" } },
        },
        links: { self: "/api/v1/board_lists/#{board_list.id}" }
      }
    }
  end

  it "serialize in the correct way" do
    expect(serialize(board_list)).to eq expected_result
  end
end
