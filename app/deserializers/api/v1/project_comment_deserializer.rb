# frozen_string_literal: true

module Api::V1
  class ProjectCommentDeserializer < ApiDeserializer
    attribute :content
    belongs_to :user
    belongs_to :project
  end
end
