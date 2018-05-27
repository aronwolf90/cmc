# frozen_string_literal: true

module Api::V1
  class WikiPageDeserializer < ApiDeserializer
    attribute :title
    attribute :content
  end
end
