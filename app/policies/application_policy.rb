# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.is_a?(Employee)
  end

  def show?
    index?
  end

  def create?
    index? && user.is_a?(Employee)
  end

  def new?
    create?
  end

  def update?
    show? && create?
  end

  def edit?
    update?
  end

  def destroy?
    user.is_a?(Admin)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def self.call(*args)
      new(*args).call
    end

    def call
      scope.all
    end
  end
end
