# frozen_string_literal: true

class ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :dash

  meta do |object, params|
    policy = Pundit::PolicyFinder.new(object).policy
    next if policy.nil?
    next if params[:current_user].nil?
    {
      permissions: {
        update: policy.new(params[:current_user], object).update?,
        destroy: policy.new(params[:current_user], object).destroy?
      }
    }
  end

  def self.eager_load_options
    []
  end
end
