# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::DocumentFilesController, type: :controller do
  let(:model) { DocumentFile.new(id: 1) }

  include_examples "standard api create action",
                   Api::V1::DocumentFiles::CreateOperation
  include_examples "standard api create action",
                   Api::V1::DocumentFiles::CreateOperation

  describe "#show" do
    it "redirect to aws url" do
      allow(ChunckUploader).to receive(:url).and_return "www.test.com/file"
      allow(DocumentFile).to receive(:find).and_return model
      sign_in Admin.new
      get :show, params: { id: model.id }

      expect(subject).to redirect_to "www.test.com/file"
    end
  end
end
