# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectStatusSerializer, type: :serializer do
  let(:project_status) do
    ProjectStatus.new(
      id: 1,
      name: "New",
      initial: false
    )
  end
  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "project-statuses",
        attributes: {
          name: "New",
          initial: false
        },
        relationships: {
          projects: {
            data: [{ id: "1", type: "projects" }]
          }
        },
        links: {
          self: "/api/v1/project_statuses/1"
        }
      }
    }
  end

  before do
    allow(project_status).to receive(:projects).and_return [Project.new(id: 1)]
  end

  it "serialize record in the correct way" do
    expect(serialize(project_status)).to eql expected_result
  end
end
