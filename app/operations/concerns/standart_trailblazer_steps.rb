# frozen_string_literal: true

module Concerns
  module StandartTrailblazerSteps
    extend ActiveSupport::Concern

    included do |base|
      step base::Nested(base::Present)
      step base::Contract::Validate(key: :data)
      step base::Contract::Persist()
    end
  end
end
