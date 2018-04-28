# frozen_string_literal: true

module Administration::Records
  module Cell
    class Index < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include ActionView::Helpers::TranslationHelper
      include FontAwesome::Rails::IconHelper
      include Kaminari::Cells
      include SimpleForm::ActionViewExtensions::FormHelper

    private

      def add_link
        link_to "New record", new_administration_record_path,
          class: "btn btn-success"
      end

      def edit_btn(record)
        link_to fa_icon(:edit), [:edit, :administration, record],
          class: "btn btn-sm btn-secondary"
      end

      def destroy_btn(record)
        link_to fa_icon(:trash), [:administration, record],
          class: "btn btn-sm btn-danger", method: :delete
      end

      def spended_time(records)
        miliseconds = records.inject(0) do |sum, record|
          end_time = record.end_time || Time.zone.now
          sum + (end_time - record.start_time)
        end
        Time.at(miliseconds / 1000).strftime("%H:%M:%S")
      end

      def this_mounth_spended_time
        spended_time(@options[:records_for_month])
      end

      def l(object, options = {})
        super(object, options) if object
      end
    end
  end
end
