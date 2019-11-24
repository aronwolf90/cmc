# frozen_string_literal: true

class Invoice < ApplicationApi
  attributes(
    :id,
    :created_at,
    :amount_due,
    :amount_paid,
    :amount_remaining,
    :pdf
  )
end
