# frozen_string_literal: true

class IssuePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def move?
    true
  end

  def destroy?
    true
  end
end
