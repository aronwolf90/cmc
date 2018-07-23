# frozen_string_literal: true

module Administration
  module Projects::Cell
    class Form < BaseFormCell
    private

      def actions(form)
        path = [:administration, model.model]

        super(form: form, cancell_path: path, destroy_path: path)
      end
    end
  end
end
