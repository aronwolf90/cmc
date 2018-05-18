# frozen_string_literal: true

module Api::V1
  class ApiDeserializer
    extend HashMapper

    class << self
      def call(*args)
        normalize(*args)
      end

      def map_relationship(name, array: false, sort_attribute: nil)
        map_relationship(name, array: array) if sort_attribute
        map from("relationships/#{name.to_s.tr("_", "-")}/data"), to(mapped_relationship_name(name, sort_attribute, array)) do |data|
          array ? mapped_relationship_values(data, sort_attribute) : data&.dig(:id)
        end
      end

      def map_relationships(*names)
        names.each do |name|
          map_relationship(name)
        end
      end

      def map_attribute(name)
        map from("attributes/#{name.to_s.tr("_", "-")}"), to(name.to_s)
      end

      def map_attributes(*names)
        names.each do |name|
          map_attribute(name)
        end
      end

    private

      def mapped_relationship_name(name, sort_attribute, array)
        if !array
          "#{name.to_s}_id"
        elsif sort_attribute
          "#{name.to_s}_attributes"
        else
          "#{name.to_s.singularize}_ids"
        end
      end

      def mapped_relationship_values(values, sort_attribute)
        values.map.with_index do |value, index|
          if sort_attribute
            { id: value[:id], sort_attribute => index }
          else
            value[:id]
          end
        end
      end
    end
  end
end
