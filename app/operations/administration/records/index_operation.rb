# frozen_string_literal: true

module Administration
  module Records
    class IndexOperation < Trailblazer::Operation
      step ModelStep
      step Policy::Pundit(RecordPolicy, :index?)
      step ThisMonthSpentTimeStep
    end
  end
end
