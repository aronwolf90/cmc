# frozen_string_literal: true

require Rails.root.join("lib", "hacks", "knock_devise", "authentificable").to_s

module Api
  module V1
    class ApiController < ApplicationController
      include Knock::Authenticable
      include Hack::KnockDevise::Authenticable
      include ActionController::Serialization
      before_action :authenticate!

    private
      attr_reader :model_class, :per_page

      def render_errors(errors)
        render json: OpenStruct.new(errors: OpenStruct.new(messages: errors)), status: :bad_request,
               serializer: ActiveModel::Serializer::ErrorSerializer
      end

      def self.model_class(model_class, **args)
        before_action -> { @model_class = model_class }, **args
      end

      def self.per_page(value, **args)
        before_action -> { @per_page = value }, **args
      end

      def serializer
        "Api::V1::#{model_class}Serializer".constantize
      end
    end
  end
end
