# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.is_a?(Admin) &&
      (premium? || User.count < 10)
  end

  def update?
    user.is_a?(Admin) || user == record
  end

private
  def premium?
    @premium ||= Organization.premium?
  end
end
