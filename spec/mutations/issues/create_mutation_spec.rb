# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issues::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      project_id: attribute_project_id,
      board_list_id: board_list_id
    )
  end

  let(:current_user) { create(:employee) }
  let(:model) { build(:issue, board_list: nil) }
  let(:project) { create(:project) }
  let(:board_list_open) { create(:board_list, project: project, kind: :open) }
  let(:board_list_other) { create(:board_list, project: project, kind: :other) }
  let(:board_list_closed) { create(:board_list, project: project, kind: :closed) }
  let(:global_open_board_list) { create(:board_list, kind: :open, project: nil)  }
  let(:global_other_board_list) { create(:board_list, kind: :other, project: nil)  }
  let(:global_closed_board_list) { create(:board_list, kind: :closed, project: nil)  }
  let(:attribute_project_id) { nil }
  let(:board_list_id) { board_list_open.id }

  before do
    board_list_open
    board_list_other
    board_list_closed
    global_open_board_list
    global_other_board_list
    global_closed_board_list
  end

  it "set ordinal_number==0" do
    expect(subject.reload.ordinal_number).to eq(0)
  end

  it "set global ordinal_number==0" do
    expect(subject.reload.global_ordinal_number).to eq(0)
  end

  it "set created_by" do
    expect(subject.reload.created_by).to eq(current_user)
  end

  context "when board_list_id is project specific and kind==open" do
    it "set orginal_number==0 and set as global_board_list the one with kind open" do
      expect(subject.reload.global_board_list).to eq global_open_board_list
    end
  end

  context "when board_list_id is project specific and kind==other" do
    let(:board_list_id) { board_list_other.id }

    it "set orginal_number==0 and set as global_board_list the one with kind open" do
      expect(subject.reload.global_board_list).to eq global_other_board_list
    end
  end

  context "when board_list_id is project specific, kind==closed" do
    let(:board_list_id) { board_list_closed.id }

    it "set global_board_list the one with kind closed" do
      expect(subject.reload.global_board_list).to eq global_closed_board_list
    end
  end

  context "when board_list_id is generic and kind==open" do
    let(:attribute_project_id) { project.id }

    it "set project specific board_list_id" do
      expect(subject.reload.board_list).to eq board_list_open
    end

    it "set the global_board_list the one with kind other" do
      expect(subject.reload.global_board_list).to eq global_open_board_list
    end
  end


  context "when board_list_id is a global one and kind==other" do
    let(:attribute_project_id) { project.id }
    let(:board_list_id) { global_other_board_list.id }

    it "set global_board_list the one with kind other" do
      expect(subject.reload.global_board_list).to eq global_other_board_list
    end
  end

  context "when board_list_id is global one specific, kind==closed" do
    let(:attribute_project_id) { project.id }
    let(:board_list_id) { global_closed_board_list.id }

    it "set orginal_number==0 and set as global_board_list the one with kind closed" do
      expect(subject.reload.global_board_list).to eq global_closed_board_list
    end
  end

  context "when no board_list_id is specified" do
    let(:attribute_project_id) { project.id }
    let(:board_list_id) { nil }

    it "use the board list of kind open" do
      expect(subject.reload.board_list.kind).to eq("open")
    end

    it "use the board list of kind open" do
      expect(subject.reload.global_board_list.kind).to eq("open")
    end
  end
end
