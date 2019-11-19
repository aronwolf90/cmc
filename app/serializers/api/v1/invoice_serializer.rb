# frozen_string_literal: true

module Api
  module V1
    class InvoiceSerializer < ApplicationSerializer
      attributes(
        :created_at,
        :amount_remaining,
        :amount_paid,
        :amount_due
      )
    end
  end
end
