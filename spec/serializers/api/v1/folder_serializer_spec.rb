# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::FolderSerializer, type: :serializer do
  let(:child_folder) { Folder.new(id: 1, name: "Test name")  }
  let(:folder) do
    Folder.new(id: 2, folders: [child_folder])
  end
  let(:expected_result) do
    {
      data: {
        id: folder.id.to_s,
        type: "folders",
        attributes: {
          name: folder.name,
          root: true
        },
        relationships: {
          "project": { data: nil },
          "folder": { data: nil },
          "folders": {
            data: [{
              id: child_folder.id.to_s,
              type: "folders"
            }]
          },
          "documents": { data: [] }
        },
        links: {
          self: "/api/v1/folders/#{folder.id}"
        }
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(folder)).to eq expected_result
  end
end
