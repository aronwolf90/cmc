# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectRecordDay, type: :model do
  it { is_expected.to belong_to(:project) }

  before do
    create(:organization, name: "public")
  end

  describe "#records" do
    subject { ProjectRecordDay.first.records }

    let!(:record) { create(:record, issue: issue) }
    let(:issue) { create(:issue, board_list: board_list) }
    let(:board_list) { create(:board_list, project: project) }
    let(:project) { create(:project) }

    it { is_expected.to eq([record]) }
  end
end
