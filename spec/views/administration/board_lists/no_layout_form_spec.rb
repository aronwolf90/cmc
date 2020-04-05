# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/board_lists/no_layout_form" do
  helper AdministrationHelper

  subject { rendered }

  let(:project) { build_stubbed(:project)  }
  let(:board_list) { BoardList.new(project: project) }
  let(:form) { Administration::BoardListForm.new(board_list) }

  before do
    sign_in(Admin.new)
    assign :model, form
    allow(Project).to receive(:all).and_return([project])
    render
  end

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
      let(:board_list) do
        build_stubbed(:board_list, project: project).tap do |board_list|
          allow(board_list).to receive(:issues).and_return([Issue.new])
        end
      end

      it { is_expected.to have_css(".disabled") }
    end
  end
end
