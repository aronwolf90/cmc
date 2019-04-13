# frozen_string_literal: true

module Administration
  module Wiki
    class CategoriesController < WikiController
      namespace Administration::WikiCategories

      public :new, :edit

      def create
        super() { %i[administration wiki content] }
      end

      def update
        super { %i[administration wiki content] }
      end

      def destroy
        super %i[administration wiki content]
      end
    end
  end
end
