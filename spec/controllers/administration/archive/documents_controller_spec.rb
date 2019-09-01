# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Archive::DocumentsController, type: :controller do
  let(:model) { Document.new(id: 1) }
  let(:form) { Administration::ArchiveDocumentForm }

  describe "#show" do
    let(:document) { build_stubbed(:document) }
    let(:user) { build_stubbed(:user) }

    before do
      sign_in(user)
      allow(Document).to receive(:find).and_return(document)
    end

    specify do
      expect(controller).to receive(:send_data) do
        controller.head :ok
      end
      get :show, params: { id: document.id }
    end
  end
end
