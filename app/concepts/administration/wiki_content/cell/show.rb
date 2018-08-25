# frozen_string_literal: true

module Administration
  module WikiContent::Cell
    class Show < ApplicationCell
    private

      def add_category_btn
        add_btn(
          model_class: WikiCategory,
          name: "category",
          path: %i[new administration wiki category]
        )
      end

      def add_page_btn
        add_btn(
          model_class: WikiPage,
          name: "page",
          path: %i[new administration wiki page]
        )
      end
    end
  end
end
