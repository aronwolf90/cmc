# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordsUserProjectQuery do
  subject { described_class.call(user: user, project: project) }

  let(:user) { create(:user) }
  let(:project) { create(:project) }

  context "record belongs to project and user" do
    let(:board_list) { create(:board_list, project: project) }
    let(:issue) { create(:issue, board_list: board_list) }
    let(:record) { create(:record, user: user, issue: issue) }

    it { is_expected.to eq([record]) }
  end

  context "record does belongs to the project" do
    before { create(:record, user: user) }

    it { is_expected.to eq([]) }
  end

  context "record belongs to the user" do
    let(:board_list) { create(:board_list, project: project) }
    let(:issue) { create(:issue, board_list: board_list) }
    let(:record) { create(:record, issue: issue) }

    it { is_expected.to eq([]) }
  end
end
