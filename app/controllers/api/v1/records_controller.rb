# frozen_string_literal: true

module Api::V1
  class RecordsController < ApiController
    include StandartActions

    def create
      super(operation: Records::CreateOperation)
    end

    def update
      super(operation: Records::UpdateOperation, model: record)
    end

  private

    def record
      @record ||= Record.find(params[:id])
    end
  end
end
