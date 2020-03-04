# frozen_string_literal: true

module Api::V1
  module Organizations
    class UpdateOperation < ApiOperation
      success :model
      step ValidateStep.new(form: UpdateForm)
      success DeserializeStep.new(deserializer: OrganizationDeserializer)
      step Policy::Pundit(OrganizationPolicy, :update?)
      success UpdateMutationStep

    private
      def model(options, **)
        options[:model] = Organization.current
      end
    end
  end
end
