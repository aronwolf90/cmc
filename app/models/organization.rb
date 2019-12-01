# frozen_string_literal: true

class Organization < ApplicationRecord
  class << self
    def current
      find_by(name: Apartment::Tenant.current)
    end

    def subscription
      current.subscription
    end

    def invoices
      current.invoices
    end

    def premium?
      !Settings.multi_tenant || current.premium?
    end
  end

  alias_attribute :to_s, :name

  def subscription
    @subscription ||=
      begin
        url = [
          Settings.payment.host,
          "api/v1/organizations",
          id,
          "subscription"
        ].compact.join("/")

        body = RestClient.get(url, Settings.payment.headers.to_h).body
        data = JSON.parse(body)["data"]
        Subscription.new(
          id: data["id"],
          quantity: data["attributes"]["quantity"],
          iban_last4: data["attributes"]["ibanLast4"],
          email: data["attributes"]["email"],
          stripe_session_id: data["attributes"]["stripeSessionId"],
          organization_id: data["attributes"]["organizationId"]
        )
      end
  end

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
            amount_remaining: invoice["attributes"]["amountRemaining"],
            pdf: invoice["attributes"]["pdf"],
          )
        end
      end
  end

  def premium?
    subscription_id.present? || !Settings.payment.enabled
  end
end
