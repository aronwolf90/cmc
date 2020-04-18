# frozen_string_literal: true

module Api
  module V1
    module Projects
      module Reminders
        class IndexQuery < ApplicationQuery
          attr_reader :project_id

          def initialize(project_id)
            @project_id = project_id
          end

          def call
            project = Project.find(project_id)
            board_lists = project.board_lists.where.not(kind: :closed)
            collection = Project.find(project_id)
              .issues.where(board_list: board_lists)
            collection = collection.where.not(due_at: nil)
              .or(collection.where.not(deadline_at: nil))

            OpenStruct.new(collection: collection)
          end
        end
      end
    end
  end
end
