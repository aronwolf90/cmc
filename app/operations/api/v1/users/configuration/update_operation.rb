# frozen_string_literal: true

module Api::V1
  module Users
    module Configuration
      class UpdateOperation < ApiOperation
        @form = UpdateForm
        @deserializer = UserDeserializer
        @policy = UserConfigurationPolicy
        @model = User
        include StandardUpdateOperationConcern
        step :model, replace: "model.build"

      private
        def model(options, params:, **args)
          options[:model] = User.find(params[:user_id])
        end
      end
    end
  end
end
