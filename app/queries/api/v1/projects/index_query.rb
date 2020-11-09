# frozen_string_literal: true

module Api
  module V1
    module Projects
      class IndexQuery < ApplicationQuery
        attr_reader :query, :includes

        def initialize(query: nil, includes: nil)
          @query = query
          @includes = includes
        end

        def call
          JsonApiQuery.call(
            Project.order(created_at: :asc, id: :asc),
            query: query,
            includes: includes
          )
        end
      end
    end
  end
end
