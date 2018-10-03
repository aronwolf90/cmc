# frozen_string_literal: true

class MvcInjectStep < ApplicationStep
  pattr_initialize :key

  def call(options, **args)
    options[:params][:data][key] = args[key]
  end
end
