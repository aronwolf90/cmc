# frozen_string_literal: true

class ContactPolicy < ApplicationPolicy
  def index?
    user.is_a? Employee
  end

  def new?
    user.is_a? Employee
  end

  def destroy?
    user.is_a? Admin
  end
end
