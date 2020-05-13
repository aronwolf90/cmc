# frozen_string_literal: true

module Api
  module V1
    class InvoicesController < ApiController
      include StandartActions
      serializer InvoiceSerializer

      def index
        authorize model_class, :index? if model_class.present?

        render_json_api json: query
      rescue Pundit::NotAuthorizedError
        head :forbidden
      end

      private
        def query
          Organization.invoices
        end
    end
  end
end
