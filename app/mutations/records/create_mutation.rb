# frozen_string_literal: true

module Records
  class CreateMutation < ApplicationMutation
    attr_private :record, :attributes, :current_user

    def initialize(attributes:, current_user:, **)
      @attributes = attributes
      @current_user = current_user
    end

    def call
      ActiveRecord::Base.transaction do
        initialize_record
        deactivate_active_records if record.active?
        create
      end
    end

  private

    def initialize_record
      @record = current_user.records.build(attributes)
    end

    def deactivate_active_records
      current_user.records.active.update_all(end_time: Time.zone.now)
    end

    def create
      record.tap(&:save!)
    end
  end
end
