# frozen_string_literal: true

module Administration
  module Records
    class IndexOperation < Trailblazer::Operation
      step IndexModelStep
      success ThisMonthSpentTimeStep
      success RecordsStep
      step Policy::Pundit(RecordPolicy, :index?)
    end
  end
end
