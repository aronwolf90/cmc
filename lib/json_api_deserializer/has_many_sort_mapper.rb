# frozen_string_literal: true

require_relative "has_many_base_mapper"

class HasManySortMapper < HasManyBaseMapper
  pattr_initialize :serializer, %i[name! attribute!]

  private
    def process(entry, index)
      { id: entry.dig(:id), attribute => index }
    end

    def to_name
      "#{name}_attributes"
    end
end
