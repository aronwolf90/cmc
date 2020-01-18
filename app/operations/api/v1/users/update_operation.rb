# frozen_string_literal: true

module Api::V1
  module Users
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = Users::UpdateDeserializer
      @policy = UserPolicy
      @model = User
      include StandardUpdateOperationConcern
    end
  end
end
