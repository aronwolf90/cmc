# frozen_string_literal: true

class Organization < ApplicationRecord
  class << self
    def current
      find_by(name: Apartment::Tenant.current)
    end

    def invoices
      current.invoices
    end
  end

  alias_attribute :to_s, :name

  def invoices
    @invoices ||=
      begin
        return [] if subscription_id.nil?
        url = [
          Settings.payment.host,
          "api/v1/subscriptions",
          subscription_id,
          "invoices"
        ].compact.join("/")

        body = RestClient.get(url, Settings.payment.headers.to_h).body
        JSON.parse(body)["data"].map do |invoice|
          Invoice.new(
            id: invoice["id"],
            created_at: invoice["attributes"]["createdAt"],
            amount_due: invoice["attributes"]["amountDue"],
            amount_paid: invoice["attributes"]["amountPaid"],
            amount_remaining: invoice["attributes"]["amountRemaining"]
          )
        end
      end
  end
end
