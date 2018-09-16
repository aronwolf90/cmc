# frozen_string_literal: true

module Administration
  module Projects
    module Records
      class IndexOperation < AdministrationOperation
        success ParentStep.new(model: Project, key: :project_id)
        success MvcIndexParentModelStep.new(relation: :project_record_days, per: 5)
        success ThisMonthSpentTimeStep
        step Policy::Pundit(RecordPolicy, :index?)
      end
    end
  end
end
