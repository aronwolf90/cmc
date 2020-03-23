# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ProjectBoardLists::UpdateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        id: 1,
        type: "project-board-lists",
        attributes: {
          name: "Test",
          'ordinal-number': "Test"
        }
      }
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to be_success
    end
  end
end
