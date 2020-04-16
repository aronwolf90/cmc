# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class IndexQuery < ApplicationQuery
        attr_reader :project_id

        def initialize(project_id: nil)
          @project_id = project_id
        end

        def call
          if Organization.global_board?
            BoardList.where(project: nil)
          elsif project_id.present?
            BoardList.where(project: project_id)
          else
            BoardList.where.not(project: nil)
          end.ordered
        end
      end
    end
  end
end
