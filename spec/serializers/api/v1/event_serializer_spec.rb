# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::EventSerializer, type: :serializer do
  let(:event) { build_stubbed(:event) }

  let(:expected_result) do
    { data: {
      id: event.id.to_s,
      type: "events",
      attributes: {
        title: event.title,
        "start-time": event.start_time,
        duration: event.duration,
        "all-day": event.all_day
      },
      links: { self: "/api/v1/events/#{event.id}" }
    } }
  end

  it "serialize record in the correct way" do
    expect(serialize(event)).to eq expected_result
  end
end
