# frozen_string_literal: true

module Records
  class EnsureUniqueActiveStep < ApplicationStep
    def call(options, model:, current_user:, **args)
      return if model.inactive?
      return if current_user.current_record.nil?
      return if model == current_user.current_record
      current_user.current_record.update!(end_time: Time.zone.now)
    end
  end
end
