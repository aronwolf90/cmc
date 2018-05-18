# frozen_string_literal: true

module Records
  class UpdateMutation < ApplicationMutation
    pattr_initialize :record, %i[attributes! current_user!]

    def call
      ActiveRecord::Base.transaction do
        assign_attributes
        deactivate_active_records if record.active?
        update
      end
    end

  private

    def assign_attributes
      record.assign_attributes(attributes)
    end

    def deactivate_active_records
      current_user.records.active.all_except(record.id)
                  .update_all(end_time: Time.zone.now)
    end

    def update
      record.save!
    end
  end
end
