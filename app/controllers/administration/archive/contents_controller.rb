# frozen_string_literal: true

module Administration
  module Archive
    class ContentsController < ArchiveBaseController
      def show
        render cell(ArchiveContent::Cell::Show)
      end
    end
  end
end
