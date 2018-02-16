# frozen_string_literal: true

module Api::V1
  module Comments
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
        Right(CommentDeserializer.normalize(params))
      end

      def create!(deserialized_params)
        Right(Comment.create!(deserialized_params))
      end
    end
  end
end
