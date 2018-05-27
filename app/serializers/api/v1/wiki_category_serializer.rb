# frozen_string_literal: true

module Api
  module V1
    class WikiCategorySerializer < ActiveModel::Serializer
      attributes :title, :root

      belongs_to :wiki_category, serializer: WikiCategorySerializer
      has_many :wiki_categories, serializer: WikiCategorySerializer
      has_many :wiki_pages, serializer: WikiPageSerializer

      def root
        object.root?
      end
    end
  end
end
