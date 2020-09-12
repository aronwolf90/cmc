# frozen_string_literal: true

module Api::V1
  class LabelsController < ApiController
    include StandartActions
    namespace ::Api::V1::Labels
    model_class Label

    public :index, :show, :update, :create, :destroy
  end
end
