# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

protected

  def self.namespace(namespace)
    define_method :namespace do
      namespace
    end
    private :namespace
  end

  def _run_options(options)
    options.merge(current_user: current_user)
  end

  def _run_params(params)
    params.to_unsafe_h
  end

  def after_sign_in_path_for(resource)
    administration_root_path
  end
end
