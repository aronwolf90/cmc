# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardLists::IndexQuery do
  subject { described_class.call }

  let!(:project_specifc_board_list) do
    create(:board_list, project: create(:project))
  end
  let!(:general_board_list) { create(:board_list, project: nil) }

  context "when project_id is passed as parameter" do
    subject { described_class.call(project_id: project.id) }

    let!(:project) { create(:project) }
    let!(:board_list1) do
      create(:board_list, project: project, ordinal_number: 2)
    end
    let!(:board_list2) do
      create(:board_list, project: project, ordinal_number: 1)
    end

    it "return the board_list correct order for the specified project" do
      expect(subject).to eq([board_list2, board_list1])
    end
  end

  context "Oranization.global_board?==false" do
    before do
      allow(Organization).to receive(:global_board?).and_return(false)
    end

    it "returns the project specific board lists" do
      expect(subject).to eq [project_specifc_board_list]
    end
  end

  context "Oranization.global_board?==true" do
    before do
      allow(Organization).to receive(:global_board?).and_return(true)
    end

    it "returns the general board lists" do
      expect(subject).to eq [general_board_list]
    end
  end
end
