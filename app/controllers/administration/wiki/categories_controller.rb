# frozen_string_literal: true

module Administration
  module Wiki
    class CategoriesController < WikiController
      namespace WikiCategories

      def new
        super
      end

      def create
        super { %i[administration wiki content] }
      end

      def edit
        super
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
