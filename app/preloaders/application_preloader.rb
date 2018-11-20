# frozen_string_literal: true

class ApplicationPreloader
  def self.call(*args)
    new(*args).call
  end
end
