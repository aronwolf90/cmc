# frozen_string_literal: true

module Api
  module V1
    class DocumentFilesController < ApiController
      include StandartActions
      model_class DocumentFile
      namespace DocumentFiles

      public :create, :update

      def show
        redirect_to ChunckUploader.new(model).s3_file.url(1.day.from_now.to_i, query: { "response-content-disposition" => "inline" })
      end
    end
  end
end
