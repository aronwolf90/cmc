# frozen_string_literal: true

module Administration
  module WikiCategories
    class DestroyOperation < AdministrationOperation
      step Model(WikiCategory, :find)
      step DestroyStep
    end
  end
end
