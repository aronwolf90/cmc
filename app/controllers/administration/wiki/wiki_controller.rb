# frozen_string_literal: true

module Administration
  module Wiki
    class WikiController < AdministrationController
      side_menu "administration/wiki"

      def index
        run Page::Index

        render cell(Page::Cell::Index)
      end
    end
  end
end
