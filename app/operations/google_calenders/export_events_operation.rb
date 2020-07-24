# frozen_string_literal: true

module GoogleCalenders
  class ExportEventsOperation < ApplicationOperation
    success :trigger_export_events

  private
    def trigger_export_events(_, organization:, **)
      Event.find_each do |event|
        GoogleCalenders::ExportEventJob.perform_later(organization, event.id)
      end
    end
  end
end
