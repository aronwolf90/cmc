# frozen_string_literal: true

module Administration
  module BoardLists
    class DestroyOperation < AdministrationOperation
      step Model(BoardList, :find)
      step DestroyStep
    end
  end
end
