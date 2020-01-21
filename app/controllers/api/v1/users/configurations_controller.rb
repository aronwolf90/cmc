# frozen_string_literal: true

module Api::V1
  module Users
    class ConfigurationsController < ApiController
      include StandartActions
      namespace Users::Configuration
      model_class User

      def update
        result = run namespace::UpdateOperation

        if result.success?
          render json: result[:model], status: :ok
        else
          render_errors(result[:errors])
        end
      end
    end
  end
end
