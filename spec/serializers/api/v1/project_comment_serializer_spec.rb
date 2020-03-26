# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectCommentSerializer, type: :serializer do
  let(:project_comment) do
    ProjectComment.new(
      id: 1,
      content: "Content",
      user_id: 1,
      project_id: 1
    )
  end

  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "project-comments",
        attributes: {
          content: "Content"
        },
        relationships: {
          project: {
            data: nil
          },
          user: {
            data: nil
          }
        }
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(project_comment)).to eql expected_result
  end
end
