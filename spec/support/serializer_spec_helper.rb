# frozen_string_literal: true

module SerializerSpecHelper
  def serialize(obj, opts = {})
    obje = ActiveModelSerializers::Adapter.create(
      described_class.send(:new, obj), opts
    )
    obje.as_json
  end
end
