# frozen_string_literal: true

module Api::V1
  class ProjectRecordDaysController < ApiController
    include StandartActions
    model_class ProjectRecordDay

    public :index

  private
    def index_meta
      return {} if params.dig(:filter, :project_id).nil?

      {
        'month-spent-time': SpendedTimeCalculator.call(
          RecordsIntervalQuery.call(
            Project.find(params[:filter][:project_id]).records,
            start_time: Time.zone.now.beginning_of_month,
            end_time: Time.zone.now.end_of_month
          )
        )
      }
    end

    def query
      model_class.ordered
    end
  end
end
