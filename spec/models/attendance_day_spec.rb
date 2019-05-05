# frozen_string_literal: true

require "rails_helper"

RSpec.describe AttendanceDay, type: :model do
  describe ".from_to" do
    specify do
      expect(described_class.from_to("22.4.2019", "28.4.2019").size).to eq(7)
    end
  end

  describe "kind" do
    subject { attendance.kind }

    context "normal week day" do
      let(:attendance) { described_class.new(day: "16.4.2019") }

      it { is_expected.to eq("normal-day") }
    end

    context "weekend day" do
      let(:attendance) { described_class.new(day: "20.4.2019") }

      it { is_expected.to eq("weekend-day") }
    end

    context "holiday day" do
      let(:attendance) { described_class.new(day: "22.4.2019") }

      it { is_expected.to eq("holiday-day") }
    end
  end

  describe "to_s" do
    subject { AttendanceDay.new(day: "22.4.2019").to_s }

    it { is_expected.to eq("Mon 22") }
  end
end
