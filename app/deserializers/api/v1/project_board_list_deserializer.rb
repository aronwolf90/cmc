# frozen_string_literal: true

module Api::V1
  class ProjectBoardListDeserializer < ApiDeserializer
    attribute :name
    attribute :ordinal_number

    belongs_to :project_status
  end
end
