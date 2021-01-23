# frozen_string_literal: true

module Api
  module V1
    class WikiCategorySerializer < TreeSerializer
      attributes :title, :root

      belongs_to :wiki_category, serializer: WikiCategorySerializer
      has_many :wiki_categories, serializer: WikiCategorySerializer
      has_many :wiki_pages, serializer: WikiPageSerializer

      link(:self) { api_v1_wiki_category_path(object) }
    end
  end
end
