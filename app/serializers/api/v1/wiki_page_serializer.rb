# frozen_string_literal: true

module Api
  module V1
    class WikiPageSerializer < ApplicationSerializer
      attributes :title
      attributes :content

      belongs_to :wiki_category, serializer: WikiCategorySerializer

      link(:self) { api_v1_wiki_page_path(object) }
    end
  end
end
