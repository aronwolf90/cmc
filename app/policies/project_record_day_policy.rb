# frozen_string_literal: true

class ProjectRecordDayPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
