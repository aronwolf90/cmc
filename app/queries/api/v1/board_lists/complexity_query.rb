# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class ComplexityQuery < ApplicationQuery
        attr_reader :board_list, :project_id

        def initialize(board_list:, project_id: nil)
          @board_list = board_list
          @project_id = project_id
        end

        def call
          if board_list.project_id.present?
            Issue.where(board_list: board_list)
          else
            if project_id.present?
              Issue.where(
                global_board_list: board_list,
                board_list_id: BoardList.where(project_id: project_id)
              )
            else
              Issue.where(global_board_list: board_list)
            end
          end.sum(:complexity)
        end
      end
    end
  end
end
