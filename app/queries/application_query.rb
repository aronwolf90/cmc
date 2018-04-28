# frozen_string_literal: true

class ApplicationQuery
  def self.call(*args)
    new(*args).call
  end
end
