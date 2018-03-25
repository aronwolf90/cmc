# frozen_string_literal: true

class InitializeStep < ApplicationStep
  attr_reader :clazz

  def initialize(clazz:)
    @clazz = clazz
  end

  def call(options, **args)
    options[:model] = clazz.new
  end
end
