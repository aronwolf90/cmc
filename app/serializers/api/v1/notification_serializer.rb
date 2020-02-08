# frozen_string_literal: true

module Api
  module V1
    class NotificationSerializer < ApplicationSerializer
      attributes(
        :subject,
        :body,
      )
    end
  end
end
