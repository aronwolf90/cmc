# frozen_string_literal: true

module Api::V1
  class RecordsController < ApiController
    include StandartActions

    def create
      super(operation: Records::CreateOperation)
    end

    def update
      super(operation: Records::UpdateOperation)
    end
  end
end
