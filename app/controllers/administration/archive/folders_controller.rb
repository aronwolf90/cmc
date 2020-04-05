# frozen_string_literal: true

module Administration
  module Archive
    class FoldersController < BaseController
      namespace Administration::ArchiveFolders

      public :new, :edit

      def create
        super { "/administration/archive" }
      end

      def update
        super { "/administration/archive" }
      end

      def destroy
        super "/administration/archive"
      end
    end
  end
end
