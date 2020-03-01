# frozen_string_literal: true

class SubscriptionPolicy < ApplicationPolicy
  def show?
    user.is_a?(Admin)
  end

  def create?
    user.is_a?(Admin)
  end
end
