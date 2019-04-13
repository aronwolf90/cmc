# frozen_string_literal: true

module Administration
  module Wiki
    module CategoriesHelper
      include AdministrationHelper

      def cancel_btn
        super(%i[administration wiki content])
      end
    end
  end
end
