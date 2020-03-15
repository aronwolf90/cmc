# frozen_string_literal: true

module Api::V1
  class ProjectDeserializer < ApiDeserializer
    attribute :name

    belongs_to :project_status
  end
end
