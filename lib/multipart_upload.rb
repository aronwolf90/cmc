# frozen_string_literal: true

class MultipartUpload
  class << self
    def start(model)
      storage.initiate_multipart_upload(bucked, name(model))
    end

    def upload(model, data)
      storage.upload_part(bucked, model.s3_id, name(model), data)
    end

    def finish(model)
      storage.complete_multipart_upload(
        bucked,
        model.s3_id,
        name(model),
        model.s3_chuncks
      )
    end

  private
    def storage
      Fog::Storage.new(AvatarUploader.fog_credentials)
    end

    def bucked
      AvatarUploader.fog_directory
    end

    def name(mode)
      model.file_before_type_cast
    end
  end
end
