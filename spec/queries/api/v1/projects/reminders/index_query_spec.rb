# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Projects::Reminders::IndexQuery do
  let(:project) { create(:project) }
  let(:board_list) { create(:board_list, project: project, kind: :open) }
  let(:closed_board_list) do
    create(:board_list, project: project, kind: :closed)
  end
  let!(:issue_due_at) do
    create(:issue, id: 1, due_at: Time.zone.now, board_list: board_list)
  end
  let!(:issue_deadline_at) do
    create(:issue, id: 2, deadline_at: Time.zone.now, board_list: board_list)
  end
  let!(:issue) { create(:issue, id: 3, board_list: board_list) }
  before do
    create(
      :issue,
      id: 4,
      due_at: Time.zone.now,
      board_list: closed_board_list
    )
  end

  it "call" do
    expect(described_class.call(project.id).collection)
      .to eq([issue_due_at, issue_deadline_at])
  end
end
