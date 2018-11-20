# frozen_string_literal: true

module Administration
  module Records
    class IndexOperation < AdministrationOperation
      success :model
      success :paginate
      success :preload
      success ThisMonthSpentTimeStep
      step Policy::Pundit(RecordPolicy, :index?)

      def model(options, current_user:, **)
        options["model"] = current_user.record_days
      end

      def paginate(options, model:, params:, **)
        options["model"] = Paginator.(model, params[:page])
      end

      def preload(options, model:, current_user:, **)
        options["model"] = Preloader.(current_user, model)
      end
    end
  end
end
