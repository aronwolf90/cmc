# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/archive/folders/form" do
  helper AdministrationHelper

  subject { rendered }

  before do
    sign_in(Admin.new)
    assign :model, Administration::ArchiveFolderForm.new(Document.new)
    render
  end

  it { is_expected.to have_selector("#data_name") }
  it { is_expected.to have_selector("#data_folder_id") }
  it { is_expected.to have_selector("input[type='submit']") }
end
