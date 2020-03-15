# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ProjectDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        name: "Test"
      },
      relationships: {
        "project-status": { data: { id: 1, type: "projects" } }
      }
    }
  end
  let(:result) do
    {
      name: "Test",
      project_status_id: 1
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to eq(result)
    end
  end
end
