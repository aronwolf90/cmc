# frozen_string_literal: true

module Administration
  module WikiContent::Cell
    class Show < ApplicationCell
    private

      def add_category_btn
        standard_btn "add category", %i[new administration wiki category]
      end

      def add_page_btn
        standard_btn "add page", %i[new administration wiki page]
      end
    end
  end
end
