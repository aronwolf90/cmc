# frozen_string_literal: true

module Administration::Dashboard
  class BaseIssuesStep < BaseIndexStep
    def self.call(options, key, collection, params:, **)
      collection = collection.includes(:records, :project)

      options["model"][:"#{key}_issues"] =
        page(collection, page: params[:"#{key}_issue_page"], per: 5)
    end
  end
end
