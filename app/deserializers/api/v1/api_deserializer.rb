# frozen_string_literal: true

module Api::V1
  class ApiDeserializer
    extend HashMapper

    def self.call(*args)
      normalize(*args)
    end
  end
end
