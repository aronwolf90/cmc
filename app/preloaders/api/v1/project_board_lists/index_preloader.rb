# frozen_string_literal: true

module Api
  module V1
    module ProjectBoardLists
      class IndexPreloader < ApplicationPreloader
        attr_accessor :collection, :projects

        def initialize(collection, projects:)
          @collection = collection
          @projects = projects
        end

        def call
          collection.each do |project_board_list|
            association = project_board_list.association(:projects)
            association.loaded!
            projects = find_projects_for_project_board_list(project_board_list)
            association.target.concat(order_projects(projects))
            projects.each do |project|
              association.set_inverse_instance(project)
            end
          end

          collection
        end

      private
        def find_projects_for_project_board_list(project_board_list)
          projects.select do |project|
            project_board_list.id == project.project_board_list_id
          end
        end

        def order_projects(projects)
          projects.sort_by do |project|
            [project.ordinal_number, project.id]
          end
        end
      end
    end
  end
end
