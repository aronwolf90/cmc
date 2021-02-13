# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardLists::ComplexityQuery do
  subject(:call) do
    described_class.call(board_list: board_list, project_id: project_id)
  end

  let!(:global_board_list) { create(:board_list, project: nil) }
  let!(:project_board_list1) { create(:board_list, project: project1) }
  let!(:project_board_list2) { create(:board_list, project: project2) }
  let!(:project1) { create(:project) }
  let!(:project2) { create(:project) }

  before do
    create(
      :issue,
      global_board_list: global_board_list,
      complexity: 5,
      board_list: project_board_list1
    )
    create(
      :issue,
      global_board_list: global_board_list,
      complexity: 7,
      project: project2,
      board_list: project_board_list2
    )
  end

  context "when the global board list is a global one" do
    let(:board_list) { global_board_list }

    context "when project_id == nil" do
      let(:project_id) { nil }

      it "returns the complexity of the global board list" do
        expect(call).to eq(12)
      end
    end

    context "when project_id != nil" do
      let(:project_id) { project1.id }

      it "returns the complexity of the global board list" do
        expect(call).to eq(5)
      end
    end
  end

  context "when the global board list is a project specific one" do
    let(:board_list) { project_board_list2 }
    let(:project_id) { nil }

    it "returns the complexity of the project specific board list" do
      expect(call).to eq(7)
    end
  end
end
