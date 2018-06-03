# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::BoardLists::Cell::Form, type: :cell do
  controller Administration::BoardListsController

  subject { cell(described_class, form).() }

  let(:form) do
    Administration::BoardListForm.new(BoardList.new)
  end

  it { is_expected.to have_selector("#data_name") }
  it { is_expected.to have_selector("#data_project_id") }
  it { is_expected.to have_text("Cancel") }
  it { is_expected.to have_selector("input[type='submit']") }
end
