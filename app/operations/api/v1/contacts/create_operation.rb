# frozen_string_literal: true

module Api::V1
  module Contacts
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = ContactDeserializer
      @model = Contact
      @policy = ContactPolicy
      include StandardCreateOperationConcern
    end
  end
end
