# frozen_string_literal: true

module Api::V1
  class RecordDaysController < ApiController
    include StandartActions
    model_class RecordDay

    public :index

  private
    def query
      model_class.ordered
    end
  end
end
