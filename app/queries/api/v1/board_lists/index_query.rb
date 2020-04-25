# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class IndexQuery < ApplicationQuery
        attr_reader :project_id, :issues_count

        def initialize(project_id: nil, issues_count: 16)
          @project_id = project_id
          @issues_count = issues_count
        end

        def call
          issues = Api::V1::BoardLists::Index::IssuesQuery.call(
            collection,
            project_id: project_id,
            count: issues_count
          )
          Api::V1::BoardLists::IndexPreloader.call(collection, issues: issues)
        end

        def collection
          if Organization.global_board?
            BoardList.where(project: nil)
          elsif project_id.present?
            BoardList.where(project: project_id)
          else
            BoardList.where.not(project: nil)
          end.ordered.includes(BoardListSerializer.eager_load_options)
        end
      end
    end
  end
end
