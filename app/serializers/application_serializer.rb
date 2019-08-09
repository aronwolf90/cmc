# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  meta do
    policy = Pundit::PolicyFinder.new(object).policy
    next if policy.nil?
    next if scope.nil?
    {
      permissions: {
        update: policy.new(scope.current_user, object).update?,
        destroy: policy.new(scope.current_user, object).destroy?
      }
    }
  end

  def self.eager_load_options
    []
  end
end
