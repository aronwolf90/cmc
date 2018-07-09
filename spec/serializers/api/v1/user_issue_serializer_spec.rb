# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UserIssueSerializer, type: :serializer do
  let(:user_issue) { build_stubbed(:user_issue) }

  let(:expected_result) do
    {
      data: {
        id: "#{user_issue.user_id},#{user_issue.issue_id}",
        type: "user-issues",
        attributes: {
          "spent-time": 60,
          "start-time": user_issue.start_time
        },
        relationships: {
          user: { data: { id: user_issue.user.id.to_s, type: "users" } },
          issue: { data: { id: user_issue.issue.id.to_s, type: "issues" } }
        }
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(user_issue)).to eq expected_result
  end
end
