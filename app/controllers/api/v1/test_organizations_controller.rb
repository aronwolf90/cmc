# frozen_string_literal: true

module Api::V1
  class TestOrganizationsController < ApiController
    include StandartActions
    skip_before_action :verify_authenticity_token
    serializer OrganizationSerializer
    namespace TestOrganizations

    public :create

    private
      def authenticate!; end
  end
end
