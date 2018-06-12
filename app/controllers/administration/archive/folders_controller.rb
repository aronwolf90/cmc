# frozen_string_literal: true

module Administration
  module Archive
    class FoldersController < ArchiveBaseController
      include Concerns::Administration::StandardActions
      namespace ArchiveFolders

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
