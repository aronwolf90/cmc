# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe Administration::ArchiveDocuments::CreateOperation do
  it_should_behave_like "standard create operation",
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
