# frozen_string_literal: true

module SerializerSpecHelper
  def serialize(obj, scope: nil, **opts)
    obje = ActiveModelSerializers::Adapter.create(
      described_class.new(obj, **opts), scope: scope
    )
    obje.as_json
  end
end
