# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def _run_options(options)
    options.merge(current_user: current_user)
  end

  def _run_params(params)
    params.to_unsafe_h
  end
end
