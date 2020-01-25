# frozen_string_literal: true

module Api
  module V1
    module StandartActions
      extend ActiveSupport::Concern

      class_methods do
        def serializer(clazz = nil)
          @serializer ||= clazz
        end
      end

      protected
        def index
          render_json_api json: query
        end

        def show
          render_json_api json: model, links: false
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

        def render_json_api(json:, links: true)
          serializer_hash =
            if json.is_a?(Array) || json.is_a?(ActiveRecord::Relation)
              { each_serializer: self.class.serializer }
            else
              { serializer: self.class.serializer }
            end

          render({
            json: json,
            include: params[:include],
            links: ({ self: request.path_info } if links),
          }.merge(serializer_hash))
        end

        def query
          JsonApiQuery.call(
            model_class.all.includes(serializer.eager_load_options),
            params.to_unsafe_h.deep_symbolize_keys
          )
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
