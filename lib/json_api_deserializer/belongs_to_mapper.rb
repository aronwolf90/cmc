# frozen_string_literal: true

require_relative "base_mapper"

class BelongsToMapper < BaseMapper
  pattr_initialize :serializer, %i[name!]

  def call
    map from(from_name), to(to_name) do |entry|
      next :hash_mapper_no_value if entry.is_a?(Hash) && !entry.key?(:id)
      entry&.dig(:id)
    end
  end

  private
    def from_name
      "relationships/#{name.to_s.tr('_', '-')}/data"
    end

    def to_name
      "#{name.to_s.singularize}_id"
    end
end
