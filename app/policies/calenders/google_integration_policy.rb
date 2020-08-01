# frozen_string_literal: true

module Calenders
  class GoogleIntegrationPolicy < ApplicationPolicy
    def destroy?
      user.is_a?(Admin)
    end
  end
end
