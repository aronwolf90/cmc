# frozen_string_literal: true

module Administration
  module Archive
    class DocumentsController < BaseController
      namespace Administration::ArchiveDocuments

      public :new, :edit

      def show
        document = Document.find(params[:id])
        send_file(
          document.file.path,
          filename: document.download_name,
          disposition: :inline
        )
      end

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
