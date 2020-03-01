# frozen_string_literal: true

class BoardListPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.is_a? Employee
  end

  def update?
    user.is_a? Employee
  end

  def destroy?
    !record.kind.in?(%w[open closed]) && super
  end
end
