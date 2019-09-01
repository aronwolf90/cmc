# frozen_string_literal: true

module Administration
  module Archive
    class DocumentsController < BaseController
      namespace Administration::ArchiveDocuments

      def show
        document = Document.find(params[:id])
        send_data(
          document.document_file.file.read,
          filename: document.download_name,
          disposition: :inline
        )
      end

      def new; end

      def edit; end

      def create
        super { %i[administration archive] }
      end

      def update
        super { %i[administration archive] }
      end

      def destroy
        super %i[administration archive]
      end
    end
  end
end
