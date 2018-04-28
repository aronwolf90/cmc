# frozen_string_literal: true

module Api::V1
  module BoardLists
    class SortOperation < ApiOperation
      step ValidateStep.new(form: SortForm)
      success ::BoardLists::SortStep.new
    end
  end
end
