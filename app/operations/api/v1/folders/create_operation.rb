# frozen_string_literal: true

module Api::V1
  module Folders
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = FolderDeserializer
      @model = Folder
      @policy = FolderPolicy
      include StandardCreateOperationConcern
    end
  end
end
