# frozen_string_literal: true

module Administration
  module BoardLists
    class CreateOperation < AdministrationOperation
      @model_step = lambda do |options, params:, current_user:, **|
        options[:model] =
          BoardList.new(project_id: current_user.selected_project_id)
      end
      @form = BoardListForm
      include MvcStandardCreateOperationConcern
    end
  end
end
