# frozen_string_literal: true

module Api
  module V1
    module Notifications
      class IndexQuery < ApplicationQuery
        attr_reader :more_id, :per_page

        def initialize(more_id:, per_page:)
          @more_id = more_id
          @per_page = per_page
        end

        def call
          MoreCollectionQuery.call(
            Notification.all,
            more_id: more_id,
            sort_key: :created_at,
            per_page: per_page
          )
        end
      end
    end
  end
end
