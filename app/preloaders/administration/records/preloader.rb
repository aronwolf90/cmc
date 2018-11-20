# frozen_string_literal: true

module Administration
  module Records
    class Preloader < ApplicationPreloader
      pattr_initialize :model, :collection

      def call
        collection.each do |record_day|
          association = record_day.association(:records)
          association.loaded!
          records = record_for_record_day(record_day)
          association.target.concat(records)
          records.each do |record|
            association.set_inverse_instance(record)
          end
        end

        collection
      end

    private

      def record_for_record_day(record_day)
        records.select do |record|
          record_day.day == record.start_time.to_date
        end
      end

      def records
        @records ||=
          model
          .records
          .where(start_time: min_day..max_day)
          .includes(:issue)
      end

      def max_day
        collection.max_by(&:day).day + 1.day
      end

      def min_day
        collection.min_by(&:day).day
      end
    end
  end
end
