# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issues::CloseMutation do
  let(:project) { create(:project) }
  let(:open_board_list) { create(:board_list, kind: :open, project: project) }
  let!(:close_board_list) { create(:board_list, kind: :closed, project: project) }
  let(:global_open_board_list) { create(:board_list, kind: :open, project: nil) }
  let!(:global_close_board_list) { create(:board_list, kind: :closed, project: nil) }
  let(:issue) do
    create(
      :issue,
      board_list: open_board_list,
      global_board_list: global_open_board_list
    )
  end
  it "change board list to the close board list" do
    expect do
      described_class.call(model: issue)
    end.to change(issue, :board_list).to(close_board_list)
  end

  it "change global board list to the close board list" do
    expect do
      described_class.call(model: issue)
    end.to change(issue, :global_board_list).to(global_close_board_list)
  end
end
