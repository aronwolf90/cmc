# frozen_string_literal: true

module Events
  class DestroyOperation < ApplicationOperation
    success :destroy_event
    success :export

  private
    def destroy_event(_, event:, **)
      event.destroy!
    end

    def export(_, organization:, event:, **)
      Events::ExportJob.perform_later(organization, event.id)
    end
  end
end
