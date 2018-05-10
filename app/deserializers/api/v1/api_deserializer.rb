# frozen_string_literal: true

module Api::V1
  class ApiDeserializer
    extend HashMapper

    def self.call(*args)
      normalize(*args)
    end

    def self.map_relationship(name, array: false)
      if array
        map from("relationships/#{name.to_s.tr("_", "-")}/data"), to(name.to_s.singularize + "_ids") do |data|
          data.map { |entry| entry[:id] }
        end
      else
        map from("relationships/#{name.to_s.tr("_", "-")}/data"), to(name.to_s + "_id") do |data|
          data&.dig(:id)
        end
      end
    end

    def self.map_relationships(*names)
      names.each do |name|
        map_relationship(name)
      end
    end

    def self.map_attribute(name)
      map from("attributes/#{name.to_s.tr("_", "-")}"), to(name.to_s)
    end

    def self.map_attributes(*names)
      names.each do |name|
        map_attribute(name)
      end
    end
  end
end
