# frozen_string_literal: true

module Api::V1
  module WikiCategories
    class CreateOperation < ApiOperation
      @form = CreateForm
      @deserializer = WikiCategoryDeserializer
      @model = WikiCategory
      @policy = WikiCategoryPolicy
      include StandardCreateOperationConcern
    end
  end
end
