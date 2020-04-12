# frozen_string_literal: true

module Api::V1
  class ProjectDeserializer < ApiDeserializer
    attribute :name
    attribute :ordinal_number
    attribute :description

    belongs_to :project_status
    belongs_to :project_board_list
    belongs_to :contact
    belongs_to :main_responsable
  end
end
