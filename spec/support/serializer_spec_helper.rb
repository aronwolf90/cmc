# frozen_string_literal: true

module SerializerSpecHelper
  def serialize(obj, opts = {})
    described_class.new(obj).serializable_hash.tap do |hash|
      hash[:data].compact!
      hash[:data][:type] = hash[:data][:type].to_s
    end
  end
end
