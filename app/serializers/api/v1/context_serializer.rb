# frozen_string_literal: true

module Api
  module V1
    class ContextSerializer < ApplicationSerializer
      belongs_to :current_user, serializer: UserSerializer, type: :users
      attributes(
        :premium,
        :user_count,
        :time_zone,
        :global_board,
        :google_calender_integrated,
        :google_calender_authorization_url
      )

      link(:self) { api_v1_context_path }
    end
  end
end
