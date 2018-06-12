# frozen_string_literal: true

module Administration
  module Archive
    class DocumentsController < ArchiveBaseController
      namespace ArchiveDocuments

      def show
        document = Document.find(params[:id])
        send_file(
          document.file.path,
          filename: document.download_name,
          disposition: :inline
        )
      end

      def new
        super
      end

      def create
        super { %i[administration archive content] }
      end

      def edit
        super
      end

      def update
        super { %i[administration archive content] }
      end
    end
  end
end
