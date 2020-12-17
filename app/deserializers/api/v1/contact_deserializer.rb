# frozen_string_literal: true

module Api::V1
  class ContactDeserializer < ApiDeserializer
    attribute :name
    attribute :description
    attribute :email
    attribute :telephone
    attribute :mobile
    attribute :fax
    attribute :address_city
    attribute :address_zip
    attribute :address_country
    attribute :address_street
    attribute :address_number
    attribute :contact_avatar_id

    has_many :projects
  end
end
