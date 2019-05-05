# frozen_string_literal: true

require "rails_helper"

describe Api::V1::AttendanceEventDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      id: 1,
      type: "attendance-events",
      attributes: {
        "from-day": "2019-01-01",
        "to-day": "2019-01-01",
        "from-time": "9:00",
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
      }
    }
  end
  let(:result) do
    {
      from_day: "2019-01-01",
      to_day: "2019-01-01",
      from_time: "9:00",
      to_time: "12:00",
      description: "Test description",
      user_id: "1"
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
