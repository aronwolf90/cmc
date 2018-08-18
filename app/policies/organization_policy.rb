# frozen_string_literal: true

class OrganizationPolicy < ApplicationPolicy
  def index?
    user.is_a?(Admin)
  end
end
