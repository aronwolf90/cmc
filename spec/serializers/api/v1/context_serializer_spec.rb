# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ContextSerializer, type: :serializer do
  let(:user) { build_stubbed(:user) }
  let(:context) do
    Context.new(
      current_user: user,
      premium: true,
      user_count: 1,
      time_zone: "Berlin",
      global_board: true,
      google_calendar_integrated: true,
      google_calendar_authorization_url: "http://test.com"
    )
  end

  let(:expected_result) do
    {
      data: {
        id: "context",
        type: "contexts",
        attributes: {
          premium: true,
          "user-count": 1,
          "time-zone": "Berlin",
          "global-board": true,
          "google-calendar-integrated": true,
          "google-calendar-authorization-url": "http://test.com"
        },
        relationships: {
          "current-user": { data: { id: user.id.to_s, type: "users" } }
        },
        links: {
          self: "/api/v1/context"
        }
      }
    }
  end

  it "serialize context in the correct way" do
    expect(serialize(context)).to eq expected_result
  end
end
