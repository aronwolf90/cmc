# frozen_string_literal: true

module Administration
  class Records::Cell::Index < Cell::Application
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

    def spended_time(record_day)
      seconds_to_time(SpentTimeCalculator.call(record_day.records))
    end

    def month_spendet_time
      seconds_to_time(@options[:this_mounth_spended_time])
    end
  end
end
