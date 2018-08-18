# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.is_a?(Admin)
  end

  def update?
    user.is_a?(Admin) || user == record
  end
end
