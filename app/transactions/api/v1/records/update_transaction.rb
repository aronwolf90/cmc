module Api::V1
  module Records
    class UpdateTransaction < ApiTransacion
      step :validate
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
          deserialized_params: RecordDeserializer.normalize(params),
          record: record
        )
      end

      def create!(deserialized_params:, record:)
        Right(record.update!(deserialized_params))
      end
    end
  end
end
