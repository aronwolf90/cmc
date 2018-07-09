# frozen_string_literal: true

module Api
  module V1
    module StandartActions
      extend ActiveSupport::Concern

    protected

      def create(operation:)
        result = run operation

        if result.success?
          render json: result[:model], status: :created
        else
          render_errors(result[:errors])
        end
      end

      def update(operation:, model:)
        result = run operation, model: model

        if result.success?
          head :no_content
        else
          render_errors(result[:errors])
        end
      end

      def destroy(model:)
        model.destroy!

        head :ok
      end

      def filter(filter_hash = params[:filter]&.to_unsafe_h)
        (filter_hash || {}).map do |key, value|
          [key, value != "null" ? value : nil]
        end.to_h
      end
    end
  end
end
