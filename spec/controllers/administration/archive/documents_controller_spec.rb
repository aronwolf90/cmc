# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Archive::DocumentsController, type: :controller do

  let(:model) { build_stubbed(:document) }
  let(:form) { Administration::ArchiveDocumentForm }
  let(:params) { {} }

  include_examples "standart new action",
    Administration::ArchiveDocuments
  include_examples "standart create action",
    Administration::ArchiveDocuments,
    %i[administration archive content]
  include_examples "standart edit action",
    Administration::ArchiveDocuments
  include_examples "standart update action",
    Administration::ArchiveDocuments,
    %i[administration archive content]
end
