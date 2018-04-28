# frozen_string_literal: true

module Concerns
  module RecordSaveOperation
    extend ActiveSupport::Concern

    included do
      success ::Records::EnsureUniqueActiveStep.new
      success SaveStep.new
    end
  end
end
