# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Issues::Cell::Form, type: :cell do
  controller Administration::IssuesController

  subject { cell(described_class, form, current_user: user).() }

  let(:user) { build_stubbed(:admin) }
  let(:board_list) { build_stubbed(:board_list)  }
  let(:form) do
    Administration::IssueForm.new(Issue.new(board_list: board_list))
  end

  it { is_expected.to have_selector("#data_title") }
  it { is_expected.to have_selector("#data_description") }
  it { is_expected.to have_selector("#data_board_list_id") }
  it { is_expected.to have_text("Cancel") }
  it { is_expected.to have_selector("input[type='submit']") }
end
