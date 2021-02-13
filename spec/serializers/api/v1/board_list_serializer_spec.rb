# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardListSerializer, type: :serializer do
  let(:issues) { build_stubbed_list(:issue, 16) }
  let(:project) { Project.new(id: 1) }
  let(:board_list) do
    build_stubbed(
      :board_list,
      project: project,
      id: 1,
      kind: "other"
    ).tap do |board_list|
      board_list.instance_variable_set(:@issues, issues)
    end
  end

  before do
    allow(Api::V1::BoardLists::ComplexityQuery)
      .to receive(:call).with(board_list: board_list, project_id: 1).and_return(3)
  end

  let(:expected_result) do
    {
      data: {
        id: board_list.id.to_s,
        type: "board-lists",
        attributes: {
          name: "name",
          kind: "other",
          complexity: 3
        },
        relationships: {
          issues: {
            data: [
              { id: issues[0].id.to_s, type: "issues" },
              { id: issues[1].id.to_s, type: "issues" },
              { id: issues[2].id.to_s, type: "issues" },
              { id: issues[3].id.to_s, type: "issues" },
              { id: issues[4].id.to_s, type: "issues" },
              { id: issues[5].id.to_s, type: "issues" },
              { id: issues[6].id.to_s, type: "issues" },
              { id: issues[7].id.to_s, type: "issues" },
              { id: issues[8].id.to_s, type: "issues" },
              { id: issues[9].id.to_s, type: "issues" },
              { id: issues[10].id.to_s, type: "issues" },
              { id: issues[11].id.to_s, type: "issues" },
              { id: issues[12].id.to_s, type: "issues" },
              { id: issues[13].id.to_s, type: "issues" },
              { id: issues[14].id.to_s, type: "issues" }
            ],
            links: {
              self: "/api/v1/board_lists/1/issues",
              next: "/api/v1/board_lists/1/issues?more_id=#{issues[14].id}"
            }
          },
          project: { data: { id: project.id.to_s, type: "projects" } },
        },
        links: { self: "/api/v1/board_lists/1" }
      }
    }
  end

  it "serialize in the correct way" do
    expect(serialize(board_list, filter: { project_id: 1 })).to eq expected_result
  end
end
