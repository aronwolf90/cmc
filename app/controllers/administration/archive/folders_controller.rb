# frozen_string_literal: true

module Administration
  module Archive
    class FoldersController < BaseController
      namespace Administration::ArchiveFolders

      public :new, :edit

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
