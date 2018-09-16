# frozen_string_literal: true

module Api::V1
  class RecordsController < ApiController
    include StandartActions
    namespace Records

    public :create, :update
  end
end
