# frozen_string_literal: true

module Api::V1
  module Folders
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = FolderDeserializer
      @model = Folder
      @policy = FolderPolicy
      include StandardUpdateOperationConcern
    end
  end
end
