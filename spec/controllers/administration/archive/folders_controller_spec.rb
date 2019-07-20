# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Archive::FoldersController, type: :controller do
  let(:model) { Folder.new(id: 1) }
  let(:form) { Administration::ArchiveFolderForm }
  let(:params) { {} }

  include_examples "standard new action",
                   Administration::ArchiveFolders
  include_examples "standard create action",
                   Administration::ArchiveFolders,
                   %i[administration archive]
  include_examples "standard edit action",
                   Administration::ArchiveFolders
  include_examples "standard update action",
                   Administration::ArchiveFolders,
                   %i[administration archive]
  include_examples "standard destroy action",
                   Administration::ArchiveFolders,
                   %i[administration archive]
end
