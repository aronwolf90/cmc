# frozen_string_literal: true

module Api::V1
  class TestOrganizationsController < ApiController
    include StandartActions
    skip_before_action :verify_authenticity_token
    serializer OrganizationSerializer
    namespace TestOrganizations
    destroy_operation Api::V1::TestOrganizations::DestroyOperation

    public :create

    def destroy
      destroy_operation.call

      head :ok
    end

    private
      def authenticate!; end
  end
end
