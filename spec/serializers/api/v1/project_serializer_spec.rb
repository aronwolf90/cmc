# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectSerializer, type: :serializer do
  let(:project) { Project.new(id: 1, name: "Test") }
  let(:project_status) { ProjectStatus.new(id: 1) }

  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "projects",
        attributes: {
          name: "Test"
        },
        relationships: {
          "project-status": {
            data: {
              id: "1",
              type: "project-statuses"
            }
          }
        },
        links: { self: "/api/v1/projects/1" }
      }
    }
  end

  before { allow(project).to receive(:project_status).and_return(project_status) }

  it "serialize project in the correct way" do
    expect(serialize(project)).to eq expected_result
  end
end
