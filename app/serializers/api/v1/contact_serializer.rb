# frozen_string_literal: true

module Api
  module V1
    class ContactSerializer < ApplicationSerializer
      attributes(
        :name,
        :description,
        :telephone,
        :mobile,
        :fax,
        :address_city,
        :address_zip,
        :address_country,
        :address_street,
        :address_number,
        :avatar_url
      )

      def avatar_url
        id = object.contact_avatar&.id || "placeholder"
        api_v1_contact_avatar_path(id: id)
      end

      link(:self) { api_v1_contact_path(object) }

      def self.eager_load_options
        %i[contact_avatar]
      end
    end
  end
end
