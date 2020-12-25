# frozen_string_literal: true

module Api::V1
  class RecordsController < ApiController
    include StandartActions
    namespace ::Api::V1::Records
    model_class Record

    public :show, :create, :update, :destroy
  end
end
