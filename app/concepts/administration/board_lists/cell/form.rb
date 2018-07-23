# frozen_string_literal: true

module Administration
  module BoardLists::Cell
    class Form < BaseFormCell
    private
      def actions(form)
        super(
          form: form,
          destroy_path: [:administration, model.model],
          cancell_path: %i[administration board]
        )
      end

      def destroy_btn(path)
        if model.model.issues.any?
          content_tag(
            :span,
            class: "btn-group",
            "data-toggle": :tooltip,
            title: "you have to remove first the issues from the list"
          ) do
            super(path, class: "disabled")
          end
        else
          super(path)
        end
      end

      def project_collection
        Project.all.map do |project|
          [project.name, project.id]
        end
      end
    end
  end
end
