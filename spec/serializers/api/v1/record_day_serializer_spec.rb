# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::RecordDaySerializer, type: :serializer do
  let(:record) { Record.new(id: 1) }
  let(:user) { User.new(id: 1) }
  let(:record_day) do
    RecordDay.new(day: "01-01-2020", user: user)
  end

  before do
    allow(record_day).to receive(:records).and_return([record])
  end

  let(:expected_result) do
    {
      data: {
        id: "01-01-2020.1",
        type: "record-days",
        attributes: {
          day: "01-01-2020",
        },
        relationships: {
          records: {
            data: [{
              id: "1",
              type: "records"
            }]
          },
          user: {
            data: {
              id: "1",
              type: "users"
            }
          }
        }
      }
    }
  end

  it "serialize record day in the correct way" do
    expect(serialize(record_day)).to eq expected_result
  end
end
