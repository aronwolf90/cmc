# frozen_string_literal: true

module Administration
  module Records
    class IndexCsvOperation < AdministrationOperation
      success :model
      step Policy::Pundit(RecordPolicy, :index?)

      def model(options, current_user:, **)
        options[:model] = current_user.records.includes(:issue)
      end
    end
  end
end
