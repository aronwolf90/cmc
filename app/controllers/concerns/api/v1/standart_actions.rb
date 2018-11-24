# frozen_string_literal: true

module Api
  module V1
    module StandartActions
      extend ActiveSupport::Concern

    protected

      def index
        render_json_api json: JsonApiQuery.(
          model_class.all.includes(serializer.eager_load_options),
          params.to_unsafe_h.deep_symbolize_keys
        )
      end

      def show
        render_json_api json: model
      end

      def create
        result = run namespace::CreateOperation

        if result.success?
          render json: result[:model], status: :created
        else
          render_errors(result[:errors])
        end
      end

      def update
        result = run namespace::UpdateOperation

        if result.success?
          head :no_content
        else
          render_errors(result[:errors])
        end
      end

      def destroy
        model.destroy!

        head :ok
      end

      def render_json_api(json:)
        render json: json, include: params[:include]
      end

      def model
        @model ||= model_class.find(id)
      end

      def id
        if params[:id].include? ","
          params[:id].split(",")
        else
          params[:id]
        end
      end
    end
  end
end
