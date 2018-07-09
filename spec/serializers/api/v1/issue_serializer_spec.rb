# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::IssueSerializer, type: :serializer do
  let(:issue) { build_stubbed(:issue) }
  let(:user) { build_stubbed(:user) }

  let(:expected_result) do
    { data: {
      id: issue.id.to_s,
      type: "issues",
      attributes: {
        title: "title",
        description: "description",
        complexity: nil,
        "my-spended-time": 60
      },
      relationships: {
        user: { data: nil },
        "board-list": {
          data: {
            id: issue.board_list.id.to_s,
            type: "board-lists"
          }
        },
        comments: { data: [] }
      },
      links: { self: "/api/v1/issues/#{issue.id}" }
    } }
  end

  before do
    allow(UserIssueSpendedTimeCalculator).to receive(:call).and_return(60.seconds)
  end

  it "serialize record in the correct way" do
    expect(serialize(issue, scope: user)).to eq expected_result
  end
end
