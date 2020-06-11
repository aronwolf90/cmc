# frozen_string_literal: true

module Api
  module V1
    module Projects
      class IndexQuery < ApplicationQuery
        attr_reader :query

        def initialize(query: nil)
          @query = query
        end

        def call
          JsonApiQuery.call(
            Project.order(created_at: :asc, id: :asc),
            query: query
          )
        end
      end
    end
  end
end
