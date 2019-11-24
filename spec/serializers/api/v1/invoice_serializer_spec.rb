# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::InvoiceSerializer, type: :serializer do
  let(:invoice) do
    Invoice.new(
      id: "in_1FbueoLeD4GoxaIE6rVfYns7",
      created_at: "2019-11-06T19:59:10Z",
      amount_due: 58668,
      amount_paid: 58668,
      amount_remaining: 0,
      pdf: "https://pay.stripe.com/invoice/invst_9KtFtihugeF8KkYEfFEJltHcg7/pdf"
    )
  end

  let(:expected_result) do
    {
      data: {
        id: "in_1FbueoLeD4GoxaIE6rVfYns7",
        type: "invoices",
        attributes: {
          "created-at": "2019-11-06T19:59:10Z",
          "amount-due": 58668,
          "amount-remaining": 0,
          "amount-paid": 58668,
          pdf: "https://pay.stripe.com/invoice/invst_9KtFtihugeF8KkYEfFEJltHcg7/pdf"
        }
      }
    }
  end

  it "serialize an invoice in the correct way" do
    expect(serialize(invoice)).to eq expected_result
  end
end
