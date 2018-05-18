# frozen_string_literal: true

require_relative "base_mapper"

class AttributeMapper < BaseMapper
  pattr_initialize :serializer, %i[name!]
  delegate :map, :from, :to, to: :serializer

  def call
    map from(name_from), to(name.to_s)
  end

private

  def name_from
    "attributes/#{name.to_s.tr("_", "-")}"
  end
end
