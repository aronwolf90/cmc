# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectBoardLists::Projects::IndexQuery do
  subject do
    described_class.call(
      project_board_list_id: project_board_list_id,
      per_page: per_page,
      more_id: more_id
    )
  end

  let(:project_status) { create(:project_status) }
  let(:project_board_list) { create(:project_board_list, project_status: project_status) }
  let!(:project1) do
    create(:project, id: 1, project_board_list: project_board_list, ordinal_number: 0)
  end
  let!(:project2) do
    create(:project, id: 2, project_board_list: project_board_list, ordinal_number: 1)
  end
  let!(:project3) do
    create(:project, id: 3, project_board_list: project_board_list, ordinal_number: 2)
  end
  let(:project_board_list_id) { project_board_list.id }

  context "when per_page is present and more_id=nil" do
    let(:per_page) { 2 }
    let(:more_id) { nil }

    it "return first n (per_page) issues" do
      expect(subject).to have_attributes(
        collection: [project1, project2],
        has_more: true
      )
    end
  end

  context "when issues exist after more_id" do
    let(:per_page) { 2 }
    let(:more_id) { 2 }

    it "return the issues after more_id" do
      expect(subject).to have_attributes(
        collection: [project3],
        has_more: false
      )
    end
  end
end
