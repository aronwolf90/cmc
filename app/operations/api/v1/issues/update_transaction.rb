# frozen_string_literal: true

module Api::V1
  module Issues
    class UpdateTransaction < ApiTransaction
      step :validate, with: ValidateOperation(form: UpdateForm)
      step :deserialize!
      step :create!

      def validate(params:, record:)
        result = UpdateForm.call(params)

        if result.success?
          Right(params: params, record: record)
        else
          Left(result.errors)
        end
      end

      def deserialize!(params:, record:)
        Right(
          deserialized_params: IssueDeserializer.normalize(params[:data]),
          record: record
        )
      end

      def create!(deserialized_params:, record:)
        Right(record.update!(deserialized_params))
      end
    end
  end
end
