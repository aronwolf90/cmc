# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class IndexQuery < ApplicationQuery
        attr_reader :project_id, :issues_count, :includes

        def initialize(project_id: nil, issues_count: 16, includes: nil)
          @project_id = project_id
          @issues_count = issues_count
          @includes = includes
        end

        def call
          issues = Api::V1::BoardLists::Index::IssuesQuery.call(
            collection,
            project_id: project_id,
            count: issues_count
          )
          issues_includes = DotStrings::SubPartExtractor.call(
            includes,
            "issues"
          )
          Api::V1::BoardLists::IndexPreloader.call(
            collection,
            issues: issues.includes(DotStrings::HashConverter.call(issues_includes))
          )
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
