# frozen_string_literal: true

module Api::V1
  class ProjectDeserializer < ApiDeserializer
    attribute :name
    attribute :ordinal_number

    belongs_to :project_status
    belongs_to :project_board_list
  end
end
