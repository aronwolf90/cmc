# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper ApplicationHelper

  protected
    attr_reader :namespace

    def self.namespace(namespace, **args)
      before_action -> { @namespace = namespace }, **args
    end

    def _run_options(options)
      options.merge(current_user: current_user)
    end

    def _run_params(params)
      params.to_unsafe_h
    end

    def _run_operation(*args)
      super.tap do |result|
        @parent = result[:parent]
        @root_model = @parent || result[:model] || result["model"]
      end
    end

    def after_sign_in_path_for(_resource)
      administration_root_path
    end

    def cell(name, model = nil, options = {}, constant = ::Cell::ViewModel, &block)
      options[:current_user] = current_user
      super
    end
end
