# frozen_string_literal: true

class BaseMapper
  def self.call(*args)
    delegate :map, :from, :to, to: :serializer

    new(*args).call
  end
end
