# frozen_string_literal: true

module Administration
  module BoardLists
    class NewOperation < AdministrationOperation
      @form = BoardListForm
      include MvcStandardNewOperationConcern
      step :assign_project_id

      def assign_project_id(options, current_user:, **)
        options[:model].project_id = current_user.selected_project_id
      end
    end
  end
end
