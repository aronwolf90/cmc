# frozen_string_literal: true

module Api::V1
  class CommentDeserializer < ApiDeserializer
    attribute :content
    belongs_to :user
    belongs_to :issue
  end
end
