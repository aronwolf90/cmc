# frozen_string_literal: true

require_relative "has_many_base_mapper"

class HasManyMapper < HasManyBaseMapper
  pattr_initialize :serializer, %i[name!]

  private
    def process(entry, _index)
      entry.dig(:id)
    end

    def to_name
      "#{name.to_s.singularize}_ids"
    end
end
