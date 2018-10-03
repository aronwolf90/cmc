# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::ArchiveFolders::Cell::Form, type: :cell do
  controller Administration::Archive::FoldersController

  subject { cell(described_class, form, current_user: user).() }

  let(:user) { Admin.new }
  let(:form) do
    Administration::ArchiveFolderForm.new(Folder.new)
  end

  it { is_expected.to have_selector("#data_name") }
  it { is_expected.to have_selector("#data_folder_id") }
  it { is_expected.to have_selector("input[type='submit']") }
end
