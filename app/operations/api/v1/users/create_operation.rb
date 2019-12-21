# frozen_string_literal: true

module Api::V1
  module Users
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = UserDeserializer
      @model = User
      @policy = UserPolicy
      include StandardCreateOperationConcern
    end
  end
end
