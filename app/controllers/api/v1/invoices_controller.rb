# frozen_string_literal: true

module Api
  module V1
    class InvoicesController < ApiController
      include StandartActions
      public :index

      private
        def query
          Organization.invoices
        end
    end
  end
end