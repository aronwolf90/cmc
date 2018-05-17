# frozen_string_literal: true

module Records
  class UpdateMutation < ApplicationMutation
    pattr_initialize :record, %i[attributes! current_user!]

    def call
      ActiveRecord::Base.transaction do
        deactivate_active_records if active?
        update
      end
    end

  private

    def active?
      attributes[:end_time].nil?
    end

    def deactivate_active_records
      current_user.records.active.all_except(record.id)
                  .update_all(end_time: Time.zone.now)
    end

    def update
      record.update!(attributes)
    end
  end
end
