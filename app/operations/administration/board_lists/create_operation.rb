# frozen_string_literal: true

module Administration
  module BoardLists
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(::BoardList, :new)
        step Contract::Build(constant: BoardListForm)
      end

      include Concerns::StandartTrailblazerSteps
    end
  end
end
