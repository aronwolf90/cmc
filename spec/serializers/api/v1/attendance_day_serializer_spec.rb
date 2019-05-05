# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::AttendanceDaySerializer, type: :serializer do
  let(:attendance_day) { AttendanceDay.new(day: "01.01.2019") }

  let(:expected_result) do
    {
      data: {
        id: "2019-01-01",
        type: "attendance-days",
        attributes: {
          day: "2019-01-01".to_date,
          kind: "holiday-day"
        }
      }
    }
  end

  it "serialize in the correct way" do
    expect(serialize(attendance_day)).to eq expected_result
  end
end
