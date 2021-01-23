# frozen_string_literal: true

module Api::V1
  class WikiCategoryDeserializer < ApiDeserializer
    attribute :title
    belongs_to :wiki_category
  end
end
