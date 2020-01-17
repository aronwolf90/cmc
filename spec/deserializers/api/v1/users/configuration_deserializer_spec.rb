# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Users::ConfigurationDeserializer do
  subject { described_class.normalize(params) }

  context "when selected_project is present" do
    let(:params) do
      {
        id: "1",
        type: "users",
        attributes: {
          type: "Admin"
        }
      }
    end
    let(:result) do
      {
        type: "Admin"
      }
    end

    it "deserialized correctly" do
      expect(subject).to eq(result)
    end
  end
end
