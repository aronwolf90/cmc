# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardLists::Issues::IndexQuery do
  subject do
    described_class.call(
      board_list_id: board_list_id,
      per_page: per_page,
      more_id: more_id,
      project_id: project_id
    )
  end

  let(:project) { create(:project) }
  let(:board_list) { create(:board_list, project: project) }
  let(:global_board_list) { create(:board_list, project: nil) }
  let!(:issue1) do
    create(
      :issue,
      id: 1,
      ordinal_number: 1,
      board_list: board_list,
      global_board_list: global_board_list
    )
  end
  let!(:issue2) do
    create(
      :issue, id: 2,
      ordinal_number: 2,
      board_list: board_list,
      global_board_list: global_board_list
    )
  end
  let!(:issue3) do
    create(
      :issue, id: 3,
      ordinal_number: 3,
      board_list: board_list,
      global_board_list: global_board_list
    )
  end
  let(:project_id) { nil }
  let(:board_list_id) { board_list.id }

  context "when per_page is present and more_id=nil" do
    let(:per_page) { 2 }
    let(:more_id) { nil }

    it "return first n (per_page) issues" do
      expect(subject).to have_attributes(
        collection: [issue1, issue2],
        has_more: true
      )
    end
  end

  context "when issues exist after more_id" do
    let(:per_page) { 2 }
    let(:more_id) { 2 }

    it "return the issues after more_id" do
      expect(subject).to have_attributes(
        collection: [issue3],
        has_more: false
      )
    end
  end

  context "when project_id!=nil and board list is a global one" do
    let(:per_page) { 200 }
    let(:more_id) { nil }
    let(:board_list_id) { global_board_list.id }
    let(:second_project) { create(:project) }
    let(:project_id) { second_project.id }
    let(:second_board_list) do
      create(:board_list, project: second_project)
    end
    let!(:second_project_issue) do
      create(
        :issue,
        global_board_list: global_board_list,
        board_list: second_board_list
      )
    end

    it "return the issues for the indicated project" do
      expect(subject).to have_attributes(
        collection: [second_project_issue],
        has_more: false
      )
    end
  end
end
