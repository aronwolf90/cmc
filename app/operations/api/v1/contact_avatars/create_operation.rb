# frozen_string_literal: true

module Api::V1
  module ContactAvatars
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = ContactAvatarDeserializer
      @model = ContactAvatar
      @policy = ContactAvatarPolicy
      include StandardCreateOperationConcern
    end
  end
end
