# frozen_string_literal: true

module Administration
  module ArchiveDocuments::Cell
    class Form < BaseFormCell
      def actions(form)
        super(
          form: form,
          destroy_path: [:administration, :archive, model.model],
          cancell_path: %i[administration archive content]
        )
      end
    end
  end
end
