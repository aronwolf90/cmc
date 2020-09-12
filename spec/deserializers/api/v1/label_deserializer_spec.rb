# frozen_string_literal: true

require "rails_helper"

describe Api::V1::LabelDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        name: "warning",
        color: "#FFFF00"
      }
    }
  end
  let(:result) do
    {
      name: "warning",
      color: "#FFFF00"
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to eq(result)
    end
  end
end
