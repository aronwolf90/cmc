# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::DocumentFilesController, type: :controller do
  let(:model) { DocumentFile.new(id: 1) }

  include_examples "standard api create action",
                  Api::V1::DocumentFiles::CreateOperation

  describe "#show" do
    let(:document_file) do
      build_stubbed(
        :document_file,
        file: File.open(Rails.root.join("spec", "fixtures", "avatar.png")), 
        document: build_stubbed(:document, name: "test")
      )
    end
    let(:user) { build_stubbed(:user) }

    before do
      sign_in(user)
      allow(DocumentFile)
        .to receive(:find).and_return(document_file)
    end

    context "when the document file exists" do
      specify do
        params = [
          "",
          filename: "test.png",
          disposition: :inline
        ]

        expect(controller).to receive(:send_data).with(*params) do
          controller.head :ok
        end
        get :show, params: { id: document_file.id }
      end
    end
  end
end
