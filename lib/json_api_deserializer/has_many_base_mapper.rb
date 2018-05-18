# frozen_string_literal: true

require_relative "base_mapper"

class HasManyBaseMapper < BaseMapper
  delegate :map, :from, :to, to: :serializer

  def call
    map from(from_name), to(to_name) do |entries|
      entries.to_a.map.with_index do |entry, index|
        process(entry, index)
      end
    end
  end

protected

  def process(entry, index)
    raise NotImplementedError
  end

  def from_name
    "relationships/#{name.to_s.tr("_", "-")}/data"
  end

  def to_name
    raise NotImplementedError
  end
end
