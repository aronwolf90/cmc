# frozen_string_literal: true

module Administration
  module Archive
    class FoldersController < ArchiveBaseController
      namespace ArchiveFolders

      public :new, :edit

      def create
        super { %i[administration archive content] }
      end

      def update
        super { %i[administration archive content] }
      end

      def destroy
        super %i[administration archive content]
      end
    end
  end
end
