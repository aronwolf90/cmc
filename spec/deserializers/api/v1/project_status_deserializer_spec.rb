# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ProjectStatusDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        name: "New"
      }
    }
  end
  let(:result) do
    {
      name: "New"
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to eq(result)
    end
  end
end
