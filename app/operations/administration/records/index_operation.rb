# frozen_string_literal: true

module Administration
  module Records
    class IndexOperation < Trailblazer::Operation
      step ModelStep
      step ThisMonthSpentTimeStep
    end
  end
end
