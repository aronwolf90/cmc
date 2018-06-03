# frozen_string_literal: true

module Administration
  module WikiContent::Cell
    class Show < ApplicationCell
    private

      def add_category_btn
        link_to "add category", %i[new administration wiki category],
          class: "btn btn-success"
      end

      def add_page_btn
        link_to "add page", %i[new administration wiki page],
          class: "btn btn-success"
      end
    end
  end
end
