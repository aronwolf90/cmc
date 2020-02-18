# frozen_string_literal: true

module Api::V1
  module TestOrganizations
    class CreateOperation < ApiOperation
      success Model(Organization, :new)
      step ValidateStep.new(form: Api::V1::Organizations::CreateForm)
      success DeserializeStep.new(deserializer: Api::V1::OrganizationDeserializer)
      success :mutation

    private
      def mutation(options, model:, current_user:, deserialized_params:, **args)
        ::TestOrganizations::CreateMutation.call(
          model: model,
          user: current_user,
          **deserialized_params
        )
      end
    end
  end
end
