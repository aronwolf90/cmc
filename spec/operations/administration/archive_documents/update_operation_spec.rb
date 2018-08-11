# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_update_operation"

RSpec.describe Administration::ArchiveDocuments::UpdateOperation do
  let(:board_list) { build_stubbed(:document) }

  before { allow(Document).to receive(:find).and_return(board_list)  }

  it_should_behave_like "standard update operation",
    Administration::ArchiveDocumentForm,
    {
      data: {
        name: "title",
        folder_id: 1
      }
    },
    {
      data: {
        anem: nil
      }
    }
end
