# frozen_string_literal: true

module Administration
  module WikiContent::Cell
    class Show < ApplicationCell
    private

      def add_category_btn
        add_btn(model_class: WikiCategory)
      end

      def add_page_btn
        add_btn(model_class: WikiPage)
      end
    end
  end
end
