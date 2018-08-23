# frozen_string_literal: true

module Api
  module V1
    module StandartActions
      extend ActiveSupport::Concern

    protected

      def index(model_class)
        render_json_api json: JsonApiQuery.(
          model_class.all,
          params.to_unsafe_h.deep_symbolize_keys
        )
      end

      def show(model)
        render_json_api json: model
      end

      def create(operation:)
        result = run operation

        if result.success?
          render json: result[:model], status: :created
        else
          render_errors(result[:errors])
        end
      end

      def update(operation:)
        result = run operation

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

      def render_json_api(json:)
        render json: json, include: params[:include]
      end
    end
  end
end
