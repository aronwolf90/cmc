# frozen_string_literal: true

module Administration
  module Records
    class DestroyOperation < AdministrationOperation
      step Model(Record, :find)
      step Policy::Pundit(RecordPolicy, :destroy?)
      step DestroyStep
    end
  end
end
