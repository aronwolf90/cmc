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
      firstname: "Tom",
      email: "test@lvh.me",
      type: "Admin",
      active: true,
      telephone_number: "0867899ß876",
      user_avatar_id: 1
    )
  end

  let(:expected_result) do
    {
      data: {
        id: user.id.to_s,
        type: "users",
        attributes: {
          lastname: "Hernandez",
          firstname: "Tom",
          email: "test@lvh.me",
          type: "Admin",
          active: true,
          "records-count": 0,
          "avatar-url": "/api/v1/user_avatars/#{user.user_avatar_id}",
          "telephone-number": "0867899ß876"
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

  before do
    allow(user).to receive(:records_count).and_return(0)
    allow(user).to receive(:avatar_url).and_return("test.png")
  end

  it "serialize record in the correct way" do
    expect(serialize(user)).to eq expected_result
  end
end
