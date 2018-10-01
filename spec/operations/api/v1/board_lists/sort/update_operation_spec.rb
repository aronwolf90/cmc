# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardLists::Sort::UpdateOperation do
  subject do
    described_class.(
      params: params,
      current_user: user
    )
  end

  let(:user) { build_stubbed(:admin)  }
  let(:params) do
    {
      data: [1, 2]
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:board_list1) { BoardList.new }
  let(:board_list2) { BoardList.new }

  before do
    allow(Api::V1::BoardLists::SortForm).to receive(:call)
      .and_return(form_result)
    allow(BoardLists::SortStep).to receive(:call)
  end

  it { is_expected.to be_success }
end
