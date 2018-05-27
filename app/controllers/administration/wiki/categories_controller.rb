# frozen_string_literal: true

module Administration
  module Wiki
    class CategoriesController < WikiController
      include Concerns::Administration::StandardActions
      namespace WikiCategories

      def new
        super
      end

      def create
        super { [:administration, :wiki, :content] }
      end
    end
  end
end
