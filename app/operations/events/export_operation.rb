# frozen_string_literal: true

module Events
  class ExportOperation < ApplicationOperation
    success :exporters!
    success :trigger_exporters

  private
    def exporters!(options, **)
      options[:exporters] ||= [GoogleCalenders::ExportEventJob]
    end

    def trigger_exporters(_, organization:, exporters:, event:, **)
      exporters.each do |exporter|
        exporter.perform_later(organization, event.id)
      end
    end
  end
end
