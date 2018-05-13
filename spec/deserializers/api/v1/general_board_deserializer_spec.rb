# frozen_string_literal: true

require "rails_helper"

describe Api::V1::GeneralBoardDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      relationships: {
        "board-lists": {
          data: [{
            id: "1",
            type: "board-lists",
            relationships: { issues: { data: [{ id: "1", type: "issues" }] } }
          }]
        }
      }
    }
  end
  let(:result) do
    {
      board_lists_attributes: [{
        issue_ids: ["1"],
        issues_attributes: [{ id: "1", ordinal_number: 0 }],
        id: "1"
      }]
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
