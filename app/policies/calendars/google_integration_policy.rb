# frozen_string_literal: true

module Calendars
  class GoogleIntegrationPolicy < ApplicationPolicy
    def destroy?
      user.is_a?(Admin)
    end
  end
end
