# frozen_string_literal: true

module Api::V1
  class ContactDeserializer < ApiDeserializer
    attribute :name
    attribute :description
    attribute :telephone
    attribute :mobile
    attribute :fax
    attribute :address_city
    attribute :address_zip
    attribute :address_country
    attribute :address_street
    attribute :address_number
    belongs_to :contact_avatar
  end
end
