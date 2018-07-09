# frozen_string_literal: true

# prevent webpack error on first api call
module Api
  module V1
  end
end

# prevent to ignore explicity nil values in the hash
# normally we dont use shortcuts for names, but we plann to create a pull
# request with this code, and the autor use this shortcuts
class HashMapper::Map
  def hash_mapper_no_value?(key, value, h)
    if h.respond_to?(:key)
      value.nil? && !h.key?(key)
    else
      value.nil?
    end
  end

  def get_value_from_input(output, input, path, meth)
    value = path.inject(input) do |h, e|
      if h.is_a?(Hash)
        v = [h[e.to_sym], h[e.to_s]].compact.first
      else
        v = h[e]
      end
      return :hash_mapper_no_value if hash_mapper_no_value?(e, v, h)
      v
    end
    delegated_mapper ? delegate_to_nested_mapper(value, e) : value
  end
end
