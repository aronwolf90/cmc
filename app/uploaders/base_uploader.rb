# frozen_string_literal: true

class BaseUploader < CarrierWave::Uploader::Base
  def store_dir
    [
      Apartment::Tenant.current,
      model.class.to_s.underscore,
      mounted_as,
      model.id
    ].compact.map(&:to_s).join("/")
  end
end
