# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::BoardLists::Cell::Form, type: :cell do
  controller Administration::BoardListsController

  subject { cell(described_class, form, current_user: user).() }

  let(:user) { build_stubbed(:admin) }
  let(:project) { build_stubbed(:project) }
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
    let(:form) do
      Administration::BoardListForm.new(build_stubbed(:board_list))
    end
    let(:issue) { build_stubbed(:issue) }

    it { is_expected.to have_text("Destroy") }

    context "with issues" do
      before { allow(form.model).to receive(:issues).and_return([issue])  }

      it { is_expected.to have_css(".disabled") }
    end
  end
end
