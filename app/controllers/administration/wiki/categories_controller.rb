# frozen_string_literal: true

module Administration
  module Wiki
    class CategoriesController < BaseController
      namespace Administration::WikiCategories

      public :new, :edit

      def create
        super { "/administration/wiki" }
      end

      def update
        super { "/administration/wiki" }
      end

      def destroy
        super "/administration/wiki"
      end
    end
  end
end
