# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  class Scope < Scope
    def call
      if user.is_a? Employee
        scope.all
      else
        scope.joins(user_projects: :user).where("users.id": user.id)
      end
    end
  end
end
