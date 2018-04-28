# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::Cell::Index, type: :cell do
  controller Administration::RecordsController

  let(:model) { { record1.start_time => [record1, record2] } }
  let(:records) { Kaminari.paginate_array([record1, record2] ).page(1) }
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

  before { Timecop.freeze }
  after { Timecop.return }

  it "record1 start_time is present" do
    expect(cell(described_class, model, records: records, records_for_month: records).().text).to include(1.hour.ago.strftime("%I:%M %P"))
  end

  it "record2 start_time is present" do
    expect(cell(described_class, model, records: records, records_for_month: records).().text).to include(3.hour.ago.strftime("%I:%M %P"))
  end

  it "record2 end_time is present" do
    expect(cell(described_class, model, records: records, records_for_month: records).().text).to include(2.hour.ago.strftime("%I:%M %P"))
  end

  it "record2 end_time is present" do
    expect(cell(described_class, model, records: records, records_for_month: records).().text).to include("issues title")
  end
end
