# frozen_string_literal: true

module Api::V1
  module UserAvatars
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = UserAvatarDeserializer
      @model = UserAvatar
      @policy = UserAvatarPolicy
      include StandardCreateOperationConcern
    end
  end
end
