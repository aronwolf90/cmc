# frozen_string_literal: true

module Api::V1
  module BoardLists
    module Sort
      class UpdateOperation < ApiOperation
        step ValidateStep.new(form: SortForm)
        success ::BoardLists::SortStep
      end
    end
  end
end
