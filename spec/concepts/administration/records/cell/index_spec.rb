# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::Cell::Index, type: :cell do
  controller Administration::RecordsController

  subject { cell(described_class, model, this_month_spended_time: this_month_spended_time).().text }

  let(:model) { Kaminari.paginate_array([record_day]).page(1) }
  let(:record_day) do
    build_stubbed(:record_day, day: Date.current).tap do |record_day|
      allow(record_day).to receive(:records).and_return([record1, record2])
    end
  end
  let(:this_month_spended_time) { 3600 * 3 }
  let(:records) { Kaminari.paginate_array([record1, record2]).page(1) }
  let(:issue) { build_stubbed(:issue, title: "issues title")  }
  let(:record1) do
    build_stubbed(
      :record,
      start_time: 1.hours.ago,
      end_time: nil,
      issue: issue
     )
  end
  let(:record2) do
    build_stubbed(
      :record,
      start_time: 3.hours.ago,
      end_time: 2.hour.ago,
      issue: issue
    )
  end

  before { Timecop.freeze("01.01.2018") }
  after { Timecop.return }

  it "record1 start_time is present" do
    expect(subject).to include(1.hour.ago.strftime("%I:%M %P"))
  end

  it "record2 start_time is present" do
    expect(subject).to include(3.hour.ago.strftime("%I:%M %P"))
  end

  it "record2 end_time is present" do
    expect(subject).to include(2.hour.ago.strftime("%I:%M %P"))
  end

  it "record2 end_time is present" do
    expect(subject).to include("issues title")
  end

  it "spended time on day is present" do
    expect(subject).to include("02:00:00")
  end

  it "spended time at this month" do
    expect(subject).to include("03:00:00")
  end
end
