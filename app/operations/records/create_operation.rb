# frozen_string_literal: true

module Records
  class CreateOperation < ApplicationOperation
    success InitializeStep.new(clazz: Record)
    include SaveOperation
  end
end
