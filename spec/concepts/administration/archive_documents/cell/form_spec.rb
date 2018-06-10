# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::ArchiveDocuments::Cell::Form, type: :cell do
  controller Administration::Archive::DocumentsController

  subject { cell(described_class, form).() }

  let(:form) do
    Administration::ArchiveDocumentForm.new(Document.new)
  end

  it { is_expected.to have_selector("#data_name") }
  it { is_expected.to have_selector("#data_folder_id") }
  it { is_expected.to have_selector("#data_file") }
  it { is_expected.to have_selector("input[type='submit']") }
end
