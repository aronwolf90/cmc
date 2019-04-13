# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/archive/documents/form" do
  helper AdministrationHelper

  subject { rendered }

  before do
    sign_in(Admin.new)
    assign :model, Administration::ArchiveDocumentForm.new(Document.new)
    render
  end

  it { is_expected.to have_selector("#data_name") }
  it { is_expected.to have_selector("#data_folder_id") }
  it { is_expected.to have_selector("#data_file") }
  it { is_expected.to have_selector("input[type='submit']") }
end
