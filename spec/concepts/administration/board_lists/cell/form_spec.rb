# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::BoardLists::Cell::Form, type: :cell do
  controller Administration::BoardListsController

  subject { cell(described_class, form, current_user: user).() }

  let(:user) { Admin.new }
  let(:project) { Project.new }
  let(:form) do
    Administration::BoardListForm.new(BoardList.new)
  end

  before { allow(Project).to receive(:all).and_return([project]) }

  it { is_expected.to have_selector("#data_name") }
  it { is_expected.to have_selector("#data_project_id") }
  it { is_expected.to have_text("Cancel") }
  it { is_expected.not_to have_text("Destroy") }
  it { is_expected.to have_selector("input[type='submit']") }

  context "persisted board list" do
    let(:board_list) { build_stubbed(:board_list, project: project)  }
    let(:form) do
      Administration::BoardListForm.new(board_list)
    end

    it { is_expected.to have_text("Destroy") }

    context "with issues" do
      let(:issue) { build_stubbed(:issue, board_list: board_list) }
      before do
        allow(form.model).to receive(:issues).and_return([issue])
      end

      it { is_expected.to have_css(".disabled") }
    end
  end
end
