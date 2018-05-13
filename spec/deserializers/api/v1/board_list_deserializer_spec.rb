# frozen_string_literal: true

require "rails_helper"

describe Api::V1::BoardListDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        name: "name"
      },
      relationships: {
        issues: { data: [{ id: 1, type: "issues" }] }
      }
    }
  end
  let(:result) do
    {
      name: "name",
      issue_ids: [1],
      issues_attributes: [{ id: 1, ordinal_number: 0 }]
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to eq(result)
    end
  end
end
