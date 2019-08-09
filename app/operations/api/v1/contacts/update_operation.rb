# frozen_string_literal: true

module Api::V1
  module Contacts
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = ContactDeserializer
      @policy = ContactPolicy
      @model = Contact
      include StandardUpdateOperationConcern
    end
  end
end
