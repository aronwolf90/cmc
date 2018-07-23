# frozen_string_literal: true

module Administration
  module WikiCategories::Cell
    class Form < BaseFormCell
      def actions(form)
        super(
          form: form,
          destroy_path: [:administration, model.model],
          cancell_path: %i[administration wiki content]
        )
      end
    end
  end
end
