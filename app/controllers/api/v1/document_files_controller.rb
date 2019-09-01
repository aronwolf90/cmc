# frozen_string_literal: true

module Api
  module V1
    class DocumentFilesController < ApiController
      include StandartActions
      model_class DocumentFile
      namespace DocumentFiles

      public :create

      def show
        send_data(
          model.file.read,
          filename: model.document.download_name,
          disposition: :inline
        )
      end
    end
  end
end
