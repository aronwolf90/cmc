# frozen_string_literal: true

require "rails_helper"

describe Api::V1::IssueDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        title: "title",
        description: "description",
        complexity: "0.5"
      },
      relationships: {
        user: { data: { id: 1, type: "users" } }
      }
    }
  end
  let(:result) do
    {
      title: "title",
      description: "description",
      complexity: "0.5",
      user_id: 1
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to eq(result)
    end
  end
end
