# frozen_string_literal: true

class ProjectCommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    user == record.user
  end
end
