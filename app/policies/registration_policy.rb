# frozen_string_literal: true

class RegistrationPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    true
  end
end
