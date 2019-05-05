# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::AttendanceEventSerializer, type: :serializer do
  let(:user) { build_stubbed(:admin, id: 1)  }
  let(:attendance_event) do
    build_stubbed(
      :attendance_event,
      id: 1,
      from_day: "2019-01-01",
      to_day: "2019-01-01",
      from_time: Time.zone.parse("9:00"),
      to_time: Time.zone.parse("12:00"),
      description: "Test description",
      user: user
    )
  end

  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "attendance-events",
        attributes: {
          "from-day": "2019-01-01".to_date,
          "to-day": "2019-01-01".to_date,
          "from-time": "09:00",
          "to-time": "12:00",
          "description": "Test description"
        },
        relationships: {
          user: {
            data: {
              id: "1",
              type: "admins"
            }
          }
        },
        links: {
          self: "/api/v1/attendance_events/1"
        }
      }
    }
  end

  it "serialize in the correct way" do
    expect(serialize(attendance_event)).to eq expected_result
  end
end
