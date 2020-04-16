# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::IssueSerializer, type: :serializer do
  let(:issue) do
    build_stubbed(
      :issue,
      due_at: "10-10-2020",
      deadline_at: "10-10-2020"
    )
  end
  let(:user) { build_stubbed(:user) }

  let(:expected_result) do
    { data: {
      id: issue.id.to_s,
      type: "issues",
      attributes: {
        title: "title",
        description: "description",
        complexity: nil,
        "due-at": "10-10-2020 00:00",
        "deadline-at": "10-10-2020 00:00"
      },
      relationships: {
        user: { data: nil },
        "board-list": {
          data: {
            id: issue.board_list.id.to_s,
            type: "board-lists"
          }
        },
        comments: { }
      },
      links: { self: "/api/v1/issues/#{issue.id}" }
    } }
  end

  it "serialize record in the correct way" do
    expect(serialize(issue, scope: user)).to eq expected_result
  end
end
