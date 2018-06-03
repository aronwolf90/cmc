# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::Cell::Form, type: :cell do
  controller Administration::RecordsController

  subject { cell(described_class, form).() }

  let(:form) { Administration::RecordForm.new(Record.new) }

  it { is_expected.to have_selector "#data_start_time" }
  it { is_expected.to have_selector "#data_end_time" }
  it { is_expected.to have_selector "#data_issue_id" }
  it { is_expected.to have_selector "input[type='submit']" }
  it { is_expected.to have_text "Cancel" }
end
