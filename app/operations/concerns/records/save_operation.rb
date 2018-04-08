# frozen_string_literal: true

module Records
  module SaveOperation
    extend ActiveSupport::Concern

    included do
      success AssigenAttributesStep.new
      success EnsureUniqueActiveStep.new
      success SaveStep.new
    end
  end
end
