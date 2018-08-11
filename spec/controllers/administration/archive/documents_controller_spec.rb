# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Archive::DocumentsController, type: :controller do

  let(:model) { build_stubbed(:document, id: 1) }
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
  include_examples "standart destroy action",
    Administration::ArchiveDocuments,
    %i[administration archive content]

  describe "#show" do
    let(:document) { build_stubbed(:document)  }
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
