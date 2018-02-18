# frozen_string_literal: true

module Api::V1
  class ValidateStep < ApiStep
    attr_reader :form

    def initialize(form:)
      @form = form
    end

    def call(options, params:, **args)
      options[:errors] = form.call(params).errors
      options[:errors].none?
    end
  end
end
