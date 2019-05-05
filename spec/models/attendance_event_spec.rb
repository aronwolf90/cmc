# frozen_string_literal: true

require "rails_helper"

RSpec.describe AttendanceEvent, type: :model do
  describe ".from_to" do
    subject { described_class.from_to("22.4.2019", "28.4.2019") }

    context "when the attendance event is in interval" do
      let!(:attendance_event) do
        create(
          :attendance_event,
          from_day: "24.04.2019",
          to_day: "25.04.2019"
        )
      end

      specify do
        is_expected.to include attendance_event
      end
    end

    context "when the from_day is before interval and to_day in interval" do
      let!(:attendance_event) do
        create(
          :attendance_event,
          from_day: "21.04.2019",
          to_day: "25.04.2019"
        )
      end

      context "when the attendance event is in interval" do
        specify do
          is_expected.to include attendance_event
        end
      end
    end

    context "when the to_day is after interval and before_day in interval" do
      let!(:attendance_event) do
        create(
          :attendance_event,
          from_day: "29.04.2019",
          to_day: "01.05.2019"
        )
      end

      context "when the attendance event is in interval" do
        specify do
          is_expected.not_to include attendance_event
        end
      end
    end
  end
end
