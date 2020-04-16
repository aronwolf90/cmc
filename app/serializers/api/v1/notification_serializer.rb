# frozen_string_literal: true

module Api
  module V1
    class NotificationSerializer < ApplicationSerializer
      set_type :notifications

      attributes(
        :subject,
        :body,
        :created_at
      )
    end
  end
end
