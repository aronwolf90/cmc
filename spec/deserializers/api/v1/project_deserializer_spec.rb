# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ProjectDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        name: "Test",
        'ordinal-number': 1,
        description: "Description"
      },
      relationships: {
        "project-status": { data: { id: 1, type: "projects" } },
        'project-board-list': {
          data: { id: 1, type: "project-board-lists" }
        },
        contact: {
          data: { id: 1, type: "contacts" }
        },
        "main-responsable": {
          "data": {
            "id": 1,
            "type": "users"
          }
        }
      }
    }
  end
  let(:result) do
    {
      name: "Test",
      project_status_id: 1,
      project_board_list_id: 1,
      ordinal_number: 1,
      description: "Description",
      contact_id: 1,
      main_responsable_id: 1
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to eq(result)
    end
  end
end
