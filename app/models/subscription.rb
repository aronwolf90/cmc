# frozen_string_literal: true

class Subscription < ApplicationApi
  attributes(
    :id,
    :stripe_session_id,
    :organization_id,
    :email,
    :quantity
  )


private
  def create
    response = RestClient.post(url, data, Settings.payment.headers.to_h)
    JSON.parse(response.body)["data"].tap do |attributes|
      self.id = attributes["id"]
      self.quantity = attributes["quantity"]
    end
  end

  def update
    response = RestClient.patch(url, data, Settings.payment.headers.to_h)
    JSON.parse(response.body)["data"].tap do |attributes|
      self.quantity = attributes["quantity"]
    end
  end

  def url
    [Settings.payment.host, "api/v1/subscriptions", id].compact.join("/")
  end

  def data
    {
      data: {
        attributes: {
          stripe_session_id: stripe_session_id,
          organization_id: organization_id,
          email: email,
          quantity: quantity
        }
      }
    }
  end
end
