# frozen_string_literal: true

module Api::V1
  module Records
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = RecordDeserializer
      @mutation = ::Records::CreateMutation
      include StandardCreateOperationConcern
    end
  end
end
