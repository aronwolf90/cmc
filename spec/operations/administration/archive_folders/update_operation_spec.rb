# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_update_operation"

RSpec.describe Administration::ArchiveFolders::UpdateOperation do
  let(:folder) { build_stubbed(:folder, id: 1)  }

  before { allow(Folder).to receive(:find).and_return(folder) }

  it_should_behave_like "standard update operation",
    Administration::ArchiveFolderForm,
      {
        data: {
          name: "name"
        },
        folder_id: 1
      },
      {
        data: {
          name: nil
        },
        folder_id: 1
      }
end
