# frozen_string_literal: true

module DotStrings
  class Base
    def self.call(*args)
      new(*args).call
    end
  end
end
