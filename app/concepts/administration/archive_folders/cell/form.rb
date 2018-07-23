# frozen_string_literal: true

module Administration
  module ArchiveFolders::Cell
    class Form < BaseFormCell
      def actions(form)
        super(
          form: form,
          cancell_path: %i[administration archive content],
          destroy_path: [:administration, :archive, model.model]
        )
      end
    end
  end
end
