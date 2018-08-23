# frozen_string_literal: true

module Registrations
  class CreateMutation < ApplicationMutation
    def call
      ActiveRecord::Base.transaction do
        create_organization
        Apartment::Tenant.create(organization_name)
        Apartment::Tenant.switch(organization_name) do
          create_user
        end
      end
    end

  private

    def create_organization
      Organization.create!(
        name: attributes[:name],
        time_zone: attributes[:time_zone]
      )
    end

    def create_user
      Admin.create!(
        firstname: attributes[:firstname],
        lastname: attributes[:lastname],
        email: attributes[:email],
        password: attributes[:password]
      )
    end

    def organization_name
      @organization_name ||= attributes[:name]
    end
  end
end
