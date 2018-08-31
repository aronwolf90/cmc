# frozen_string_literal: true

module Administration
  module ProjectRecords
    class IndexOperation < AdministrationOperation
      success ProjectStep
      success IndexModelStep
      success RecordsStep
      success ThisMonthSpentTimeStep
      step Policy::Pundit(RecordPolicy, :index?)
    end
  end
end
