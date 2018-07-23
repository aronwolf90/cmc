# frozen_string_literal: true

module Administration
  module Records::Cell
    class Form < BaseFormCell
    private
      def actions(form)
        super(
          form: form,
          destroy_path: [:administration, model.model],
          cancell_path: %i[administration records]
        )
      end
    end
  end
end
