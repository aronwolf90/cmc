# frozen_string_literal: true

module Api
  module V1
    class DocumentFilesController < ApiController
      include StandartActions
      model_class DocumentFile
      namespace DocumentFiles

      public :create, :update

      def show
        redirect_to ChunckUploader.url(model)
      end
    end
  end
end
