# frozen_string_literal: true

require "rails_helper"

describe Api::V1::EventDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        "title": "Title",
        "start-time": "1-1-2019",
        "all-day": true,
        duration: 1
      }
    }
  end
  let(:result) do
    {
      title: "Title",
      start_time: "1-1-2019",
      all_day: true,
      duration: 1
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
