# frozen_string_literal: true

namespace :storage do
  desc "Create a aws bucket"
  task create: :environment do
    Fog::Storage
      .new(AvatarUploader.fog_credentials)
      .directories
      .create(key: "cmc")
  end

  desc "Drop a aws bucket"
  task drop: :environment do
    directory = Fog::Storage
      .new(AvatarUploader.fog_credentials)
      .directories
      .get("cmc")
    directory.files.each(&:destroy)
    directory.destroy
  end
end
