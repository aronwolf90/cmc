# frozen_string_literal: true

module Administration
  module Organizations::Cell
    class Form < BaseFormCell
    private
      def actions(form)
        super(
          form: form,
          cancell_path: %i[administration root]
        )
      end
    end
  end
end
