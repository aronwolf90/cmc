# frozen_string_literal: true

module Api
  module V1
    class ContextSerializer < ApplicationSerializer
      set_type :contexts

      belongs_to :current_user,
        serializer: UserSerializer, record_type: 'users'
      attributes :premium, :user_count, :time_zone, :global_board

      link(:self) { '/api/v1/context/' }
    end
  end
end
