# frozen_string_literal: true

require "rails_helper"

describe Api::V1::IssueDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        title: "title",
        description: "description",
        complexity: "0.5",
        "ordinal-number": 1,
        "due-at": "10-10-2020 00:00",
        "deadline-at": "10-10-2020 00:00"
      },
      relationships: {
        user: { data: { id: 1, type: "users" } },
        "board-list": { data: { id: 1, type: "board-lists" } },
        project: { data: { id: 1, type: "projects" } },
        labels: { data: [ { id: 1, type: "labels" } ] }
      }
    }
  end
  let(:result) do
    {
      title: "title",
      description: "description",
      complexity: "0.5",
      user_id: 1,
      board_list_id: 1,
      ordinal_number: 1,
      due_at: "10-10-2020 00:00",
      deadline_at: "10-10-2020 00:00",
      project_id: 1,
      label_ids: [1]
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to eq(result)
    end
  end
end
