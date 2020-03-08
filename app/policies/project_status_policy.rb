# frozen_string_literal: true

class ProjectStatusPolicy < ApplicationPolicy
  def index?
    user.is_a? Employee
  end
end
