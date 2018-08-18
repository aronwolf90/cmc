# frozen_string_literal: true

module Api::V1
  module Users
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = UserDeserializer
      @policy = UserPolicy
      include StandardUpdateOperationConcern
    end
  end
end
