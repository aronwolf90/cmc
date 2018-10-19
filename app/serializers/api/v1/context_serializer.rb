# frozen_string_literal: true

module Api
  module V1
    class ContextSerializer < ApplicationSerializer
      belongs_to :current_user, serializer: UserSerializer
    end
  end
end
