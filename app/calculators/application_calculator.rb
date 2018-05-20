# frozen_string_literal: true

class ApplicationCalculator
  pattr_initialize :records

  def self.call(*args)
    new(*args).call
  end
end
