# frozen_string_literal: true

module Api::V1
  module Users
    class ConfigurationsController < ApiController
      include StandartActions
      namespace Users::Configuration
      model_class User

      public :update
    end
  end
end
