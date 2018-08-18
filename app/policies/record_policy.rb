# frozen_string_literal: true

class RecordPolicy < ApplicationPolicy
  def index?
    true
  end

  def destroy?
    user.is_a?(Admin) || record.user == user
  end
end
