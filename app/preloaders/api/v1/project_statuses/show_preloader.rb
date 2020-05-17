# frozen_string_literal: true

module Api
  module V1
    module ProjectStatuses
      class ShowPreloader < ApplicationPreloader
        attr_accessor :project_status, :project_board_lists

        def initialize(project_status, project_board_lists:)
          @project_status = project_status
          @project_board_lists = project_board_lists
        end

        def call
          association = project_status.association(:project_board_lists)
          return project_status if association.loaded?

          association.loaded!
          association.target.concat(project_board_lists)
          project_board_lists.each do |project_board_list|
            association.set_inverse_instance(project_status)
          end

          project_status
        end
      end
    end
  end
end
