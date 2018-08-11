# frozen_string_literal: true

module Registrations
  class CreateMutation < ApplicationMutation
    attr_reader :attributes, :model

    def initialize(attributes:, model:, **)
      @attributes = attributes
      @model = model
    end

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
      model[:organization].update!(attributes[:organization])
    end

    def create_user
      model[:user].update!(attributes[:user].except(:confirmation_password))
    end

    def organization_name
      @organization_name ||= attributes[:organization][:name]
    end
  end
end
