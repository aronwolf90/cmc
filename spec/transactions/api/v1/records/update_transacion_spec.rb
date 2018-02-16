# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Records::UpdateTransaction do
  subject { described_class.call(params: params, record: record) }

  let(:record) { build_stubbed(:record) }
  let(:start_time) { Time.zone.now }
  let(:end_time) { Time.zone.now }
  let(:params) do
    {
      data: {
        id: 1,
        type: "records",
        attributes: {
          "start-time": start_time,
          "end-time": end_time
        },
        relationships: {
          user: { data: { id: 1, type: "users" } },
          issue: { data: { id: 1, type: "issues" } }
        }
      }
    }
  end

  before do
    allow(Api::V1::Records::UpdateForm).to receive(:call).and_return(double("success?": true))
    allow(Api::V1::RecordDeserializer).to receive(:normalize).and_return(start_time: Time.zone.now, user_id: 1, issue_id: 1)
    allow(record).to receive(:update!)
  end

  it "correct classes have been called" do
    expect(Api::V1::Records::UpdateForm).to receive(:call)
    expect(Api::V1::RecordDeserializer).to receive(:normalize)
    expect(record).to receive(:update!)

    subject
  end
end
