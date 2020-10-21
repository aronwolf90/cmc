# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::IssueSerializer, type: :serializer do
  let(:issue) do
    build_stubbed(
      :issue,
      due_at: "10-10-2120",
      deadline_at: "10-10-2120",
      created_by: User.new(id: 1)
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
        "due-at": "10-10-2120 00:00",
        "deadline-at": "10-10-2120 00:00",
        status: :none
      },
      relationships: {
        user: { data: nil },
        labels: {
          data: [{
            id: "1",
            type: "labels"
          }]
        },
        "created-by": {
          data: {
            id: "1",
            type: "users"
          }
        }
      },
      links: { self: "/api/v1/issues/#{issue.id}" }
    } }
  end

  before do
    allow(issue).to receive(:labels).and_return([Label.new(id: 1)])
  end

  it "serialize record in the correct way" do
    expect(serialize(issue, scope: user)).to eq expected_result
  end
end
