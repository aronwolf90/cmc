# frozen_string_literal: true

module Records
  class UpdateMutation < CreateMutation
  private
    def deactivate_active_records
      user
        .records
        .active
        .all_except(model.id)
        .update_all(end_time: Time.zone.now)
    end
  end
end
