# frozen_string_literal: true

require "rails_helper"

RSpec.describe IssuesProjectQuery do
  subject do
    described_class.call(
      Issue.all,
      project_id: project_id
    )
  end

  context "issue belongs to project" do
    let(:project) { create(:project) }
    let(:board_list) { create(:board_list, project: project) }
    let!(:issue) { create(:issue, board_list: board_list) }
    let(:project_id) { project.id }

    it { is_expected.to eq([issue]) }
  end

  context "issue does not belongs to the project" do
    let(:project) { create(:project) }
    let(:board_list) { create(:board_list, project: project) }
    let(:project_id) { 100 }
    before { create(:issue, board_list: board_list) }

    it { is_expected.to eq([]) }
  end
end
