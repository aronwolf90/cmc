# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Archive::DocumentsController, type: :controller do
  let(:model) { Document.new(id: 1) }
  let(:form) { Administration::ArchiveDocumentForm }

  include_examples "standard new action",
                   Administration::ArchiveDocuments
  include_examples "standard create action",
                   Administration::ArchiveDocuments,
                   %i[administration archive]
  include_examples "standard edit action",
                   Administration::ArchiveDocuments
  include_examples "standard update action",
                   Administration::ArchiveDocuments,
                   %i[administration archive]
  include_examples "standard destroy action",
                   Administration::ArchiveDocuments,
                   %i[administration archive]

  describe "#show" do
    let(:document) { build_stubbed(:document) }
    let(:user) { build_stubbed(:user) }

    before do
      sign_in(user)
      allow(Document).to receive(:find).and_return(document)
    end

    specify do
      expect(controller).to receive(:send_file) do
        controller.head :ok
      end
      get :show, params: { id: document.id }
    end
  end
end
