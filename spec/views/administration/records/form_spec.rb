# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/records/form" do
  helper AdministrationHelper

  subject { rendered }

  let(:user) { build_stubbed(:admin) }
  let(:form) { Administration::RecordForm.new(Record.new) }

  before do
    sign_in(Admin.new)
    assign :model, form
    render
  end

  it { is_expected.to have_selector "#data_start_time" }
  it { is_expected.to have_selector "#data_end_time" }
  it { is_expected.to have_selector "#data_issue_id" }
  it { is_expected.to have_selector "input[type='submit']" }
  it { is_expected.to have_text "Cancel" }
end
