# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/issues/form" do
  helper AdministrationHelper

  subject { rendered }

  let(:board_list) { BoardList.new(id: 1) }
  let(:form) do
    Administration::IssueForm.new(Issue.new(board_list: board_list))
  end

  before do
    sign_in(Admin.new)
    assign :model, form
    assign :parent, board_list
    render
  end

  it { is_expected.to have_selector("#data_title") }
  it { is_expected.to have_selector("#data_description") }
  it { is_expected.to have_text("Cancel") }
  it { is_expected.to have_selector("input[type='submit']") }
end
