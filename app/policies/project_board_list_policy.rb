# frozen_string_literal: true

class ProjectBoardListPolicy < ApplicationPolicy
  def index?
    user.is_a? Employee
  end

  def new?
    user.is_a? Employee
  end

  def destroy?
    user.is_a?(Employee) && !record&.projects&.exists?
  end
end
