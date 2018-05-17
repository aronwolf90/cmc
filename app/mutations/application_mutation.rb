# frozen_string_literal: true

class ApplicationMutation
  def self.call(*args)
    new(*args).call
  end
end
