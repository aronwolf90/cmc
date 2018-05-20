# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordsWithoutProjectQuery do
  subject { described_class.call(Record.all) }

  context "record belongs to project" do
    let(:project) { create(:project) }
    let(:board_list) { create(:board_list, project: project) }
    let(:issue) { create(:issue, board_list: board_list) }

    before { create(:record, issue: issue) }

    it { is_expected.to eq([]) }
  end

  context "record not belongs to project" do
    let!(:record) { create(:record, issue: nil) }

    it { is_expected.to eq([record]) }
  end
end
