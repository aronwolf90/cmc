# frozen_string_literal: true

module Administration
  module BoardLists
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(::BoardList, :new)
        step Contract::Build(constant: BoardListForm)
      end

      step Nested(Present)
      step Contract::Validate(key: :data)
      step Contract::Persist()
    end
  end
end
