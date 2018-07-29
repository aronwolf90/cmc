# frozen_string_literal: true

module Administration
  module WikiPages::Cell
    class Form < BaseFormCell
      def actions(form)
        super(
          form: form,
          cancell_path: %i[administration wiki content]
        )
      end
    end
  end
end
