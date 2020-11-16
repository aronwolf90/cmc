# frozen_string_literal: true

class Organization < ApplicationRecord
  scope :ordered, -> { order(created_at: :desc, id: :desc)  }

  class << self
    def current
      find_by(name: Apartment::Tenant.current)
    end

    def subscription
      current&.subscription
    end

    def invoices
      current&.invoices
    end

    def premium?
      !Settings.multi_tenant || current.premium?
    end

    def global_board?
      current&.global_board? || false
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
          organization_id: data["attributes"]["organizationId"],
          premia: data["attributes"]["premia"]
        )
      rescue RestClient::NotFound
        nil
      end
  end

  def invoices
    @invoices ||=
      begin
        url = [
          Settings.payment.host,
          "api/v1/organizations",
          id,
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
      rescue RestClient::NotFound
        []
      end
  end

  def premium?
    subscription_id.present? || !Settings.payment.enabled
  end

  def google_calendar_authorization_data
    GoogleAuthorizationData.new(
      access_token: google_calendar_access_token,
      expires_at: google_calendar_expires_at&.to_datetime,
      refresh_token: google_calendar_refresh_token
    )
  end

  def google_calendar_authorization_data=(authorization_data)
    self.google_calendar_access_token = authorization_data.access_token
    self.google_calendar_expires_at = authorization_data&.expires_at
    self.google_calendar_refresh_token = authorization_data.refresh_token
  end
end
