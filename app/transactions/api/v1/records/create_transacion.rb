module Api::V1::Records
  class CreateTransacion < ApiTransacion
    step :validate
    step :deserialize!
    step :create!

    def validate(params)
      result = CreateForm.call(params)

      if result.success?
        Right(params)
      else
        Left(result.errors)
      end
    end

    def deserialize!(params)
      Right(CreateDeserializer.normalize(params))
    end

    def create!(deserialized_params)
      Right(Record.create!(deserialized_params))
    end
  end
end
