# frozen_string_literal: true

module Administration
  module Wiki
    class CategoriesController < BaseController
      namespace Administration::WikiCategories

      public :new, :edit

      def create
        super { %i[administration wiki] }
      end

      def update
        super { %i[administration wiki] }
      end

      def destroy
        super %i[administration wiki]
      end
    end
  end
end
