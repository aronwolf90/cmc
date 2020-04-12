# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectSerializer, type: :serializer do
  let(:project) do
    Project.new(
      id: 1,
      name: "Test",
      description: "Description",
      folder: Folder.new(id: 1),
      contact: Contact.new(id: 1),
      main_responsable: User.new(id: 1)
    )
  end
  let(:project_status) { ProjectStatus.new(id: 1) }

  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "projects",
        attributes: {
          name: "Test",
          description: "Description"
        },
        relationships: {
          "project-status": {
            data: {
              id: "1",
              type: "project-statuses"
            }
          },
          "folder": {
            data: {
              id: "1",
              type: "folders"
            }
          },
          contact: {
            data: {
              id: "1",
              type: "contacts"
            }
          },
          "main-responsable": {
            data: {
              id: "1",
              type: "users"
            }
          }
        },
        links: { self: "/api/v1/projects/1" }
      }
    }
  end

  before do
    allow(project).to receive(:project_status).and_return(project_status)
  end

  it "serialize project in the correct way" do
    expect(serialize(project)).to eq expected_result
  end
end
