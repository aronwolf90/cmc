# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UserSerializer, type: :serializer do
  let(:project) { build_stubbed(:project) }
  let(:issue) { build_stubbed(:issue) }
  let(:record) { build_stubbed(:record) }

  let(:user) do
    build_stubbed(
      :user,
      selected_project: project,
      issues: [issue],
      current_record: record,
      lastname: "Hernandez",
      firstname: "Tom"
    )
  end

  let(:expected_result) do
    {
      data: {
        id: user.id.to_s,
        type: "users",
        attributes: {
          lastname: "Hernandez",
          firstname: "Tom"
        },
        relationships: {
          "selected-project": {
            data: {
              id: project.id.to_s,
              type: "projects"
            }
          },
          issues: {
            data: [{
              id: issue.id.to_s,
              type: "issues"
            }]
          },
          "current-record": {
            data: {
              id: record.id.to_s,
              type: "records"
            }
          }
        },
        links: { self: "/api/v1/users/#{user.id}" }
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(user)).to eq expected_result
  end
end
