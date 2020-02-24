# frozen_string_literal: true

class CreateNotificationsJob < ApplicationJob
  prepend Concerns::OrganizationSpecificJob

  def perform
    Jobs::CreateNotificationsOperation.call(date: Time.zone.now)
  end
end
