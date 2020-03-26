# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ProjectCommentDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        content: "comment"
      },
      relationships: {
        user: { data: { id: 1, type: "users" } },
        project: { data: { id: 1, type: "projects" } }
      }
    }
  end
  let(:result) do
    {
      content: "comment",
      user_id: 1,
      project_id: 1
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
