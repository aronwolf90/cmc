# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def destroy?
    user.is_a? Admin
  end
end
