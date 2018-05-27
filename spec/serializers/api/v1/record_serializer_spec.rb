# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::RecordSerializer, type: :serializer do
  let(:issue) { build_stubbed(:issue) }
  let(:user) { build_stubbed(:user) }
  let(:record) { build_stubbed(:record, user: user, issue: issue) }

  let(:expected_result) do
    { data: {
      id: record.id.to_s,
      type: "records",
      attributes: {
        "start-time": record.start_time,
        "end-time": record.end_time
      },
      relationships: {
        user: { data: {
          id: user.id.to_s,
          type: "users"
        } },
        issue: { data: {
          id: issue.id.to_s,
          type: "issues"
        } }
      },
      links: { self: "/api/v1/records/#{record.id}" }
    } }
  end

  it "serialize record in the correct way" do
    expect(serialize(record)).to eq expected_result
  end
end
