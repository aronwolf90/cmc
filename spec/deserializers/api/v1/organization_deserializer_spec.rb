# frozen_string_literal: true

require "rails_helper"

describe Api::V1::OrganizationDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        premium: true
      }
    }
  end
  let(:result) do
    {
      premium: true
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to eq(result)
    end
  end
end
