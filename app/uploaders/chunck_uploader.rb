# frozen_string_literal: true

class ChunckUploader < BaseUploader
  def start_mulipart_upload(headers = {})
    model.s3_id = fog_storage.initiate_multipart_upload(
      self.fog_directory,
      file_path,
      headers
    ).body["UploadId"]
  end

  def upload_part(data)
    model.s3_parts << fog_storage.upload_part(
      self.fog_directory,
      file_path,
      model.s3_id,
      model.s3_parts.size + 1,
      data
    ).data[:headers]["ETag"]
  end

  def complete_multipart_upload
    fog_storage.complete_multipart_upload(
      self.fog_directory,
      file_path,
      model.s3_id,
      model.s3_parts
    )
  end

  def upload(file)
    s3_bucket.files.create(
      key: "#{store_dir}/#{model.file}",
      body: File.open(file),
      public: false
    )
  end

  def url
    s3_file.url(
      1.day.from_now.to_i,
      query: { "response-content-disposition" => "inline" }
    )
  end

  def s3_file
    s3_bucket.files.get(file_path)
  end

  def s3_bucket
    fog_storage.directories.new(key: self.fog_directory)
  end

  def self.url(model)
    new(model).url
  end

  private
    def fog_storage
      Fog::Storage.new(self.class.fog_credentials)
    end

    def file_path
      "#{store_dir}/#{model.file_before_type_cast}"
    end
end
