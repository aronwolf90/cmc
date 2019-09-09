# frozen_string_literal: true

module DocumentFiles
  class UpdateMutation < StandardUpdateMutation
    def call
      uploader = ChunckUploader.new(model)
      uploader.upload_part(attributes[:file].read)
      model.save!
      uploader.complete_multipart_upload unless attributes[:not_finished]
    end
  end
end
