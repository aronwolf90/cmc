# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecordsMonthUserProjectQuery do
  subject { described_class.call(user: user, project: project) }

  let(:user) { create(:admin) }
  let(:project) { create(:project) }
  let(:board_list) { create(:board_list, project: project) }
  let(:issue) { create(:issue, board_list: board_list) }
  let(:record_this_month) do
    create(
      :record,
      start_time: 1.hour.ago,
      end_time: 1.minute.ago,
      user: user,
      issue: issue
    )
  end

  before { Timecop.freeze("30.12.2019 15:30") }
  after { Timecop.return  }

  before do
    create(
      :record,
      start_time: 1.month.ago - 1.hour,
      end_time: 1.month.ago,
      user: user,
      issue: issue
    )
  end

  it { is_expected.to eq [record_this_month] }
end
