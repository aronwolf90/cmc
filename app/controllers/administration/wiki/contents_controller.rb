# frozen_string_literal: true

module Administration
  module Wiki
    class ContentsController < WikiController
      side_menu "administration/wiki"

      def show
        render cell(WikiContent::Cell::Show)
      end
    end
  end
end
