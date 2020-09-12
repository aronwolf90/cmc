# frozen_string_literal: true

class LabelPolicy < ApplicationPolicy
  def destroy?
    user.is_a?(Employee)
  end
end
