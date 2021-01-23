# frozen_string_literal: true

module Api::V1
  module WikiCategories
    class UpdateOperation < ApiOperation
      @form = UpdateForm
      @deserializer = WikiCategoryDeserializer
      @policy = WikiCategoryPolicy
      @model = WikiCategory
      include StandardUpdateOperationConcern
    end
  end
end
