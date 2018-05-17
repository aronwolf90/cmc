# frozen_string_literal: true

module Records
  class CreateMutation < ApplicationMutation
    pattr_initialize %i[attributes! current_user!]

    def call
      ActiveRecord::Base.transaction do
        deactivate_active_records if active?
        create
      end
    end

  private

    def active?
      attributes[:end_time].nil?
    end

    def deactivate_active_records
      current_user.records.active.update_all(end_time: Time.zone.now)
    end

    def create
      current_user.records.create!(attributes)
    end
  end
end
