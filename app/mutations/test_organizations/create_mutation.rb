# frozen_string_literal: true

module TestOrganizations
  class CreateMutation < ApplicationMutation
    def call
      Organizations::DestroyMutation.call(
        model: organization
      ) if organization.present?
      mutation(Organization, :create).call(
        model: model,
        name: "test-organization",
        time_zone: "Berlin",
        global_board: attributes[:global_board] || false
      )
      model.update!(id: 1)
      model.update!(subscription_id: attributes[:premium] || nil) if attributes[:premium].present?
      ActiveRecord::Base.connection.reset_pk_sequence!("public.organizations")
      ActiveRecord::Base.connection.clear_cache! # TODO: check why prepared_statements problem appear on rails 6
    end

    def organization
      @organization ||= Organization.find_by(name: "test-organization")
    end
  end
end
