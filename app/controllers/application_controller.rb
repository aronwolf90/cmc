# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected

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
