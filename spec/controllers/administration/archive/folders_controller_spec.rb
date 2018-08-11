# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Archive::FoldersController, type: :controller do
  let(:model) { build_stubbed(:folder) }
  let(:form) { Administration::ArchiveFolderForm }
  let(:params) { {} }

  include_examples "standart new action",
    Administration::ArchiveFolders
  include_examples "standart create action",
    Administration::ArchiveFolders,
    %i[administration archive content]
  include_examples "standart edit action",
    Administration::ArchiveFolders
  include_examples "standart update action",
    Administration::ArchiveFolders,
    %i[administration archive content]
  include_examples "standart destroy action",
    Administration::ArchiveFolders,
    %i[administration archive content]
end
