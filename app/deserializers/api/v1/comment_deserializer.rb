# frozen_string_literal: true

module Api::V1
  class CommentDeserializer < ApiDeserializer
    map_attribute :content
    map_relationships :user, :issue
  end
end
