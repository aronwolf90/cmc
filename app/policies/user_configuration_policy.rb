# frozen_string_literal: true

class UserConfigurationPolicy < ApplicationPolicy
  def update?
    user.is_a?(Admin)
  end
end
