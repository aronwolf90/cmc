# frozen_string_literal: true

CarrierWave.configure do |config|
  if ENV["AWS_ENABLED"].present?
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["AWS_KEY"],
      aws_secret_access_key: ENV["AWS_SECRET"],
      region: ENV["AWS_REGION"],
      endpoint: "https://#{ENV['AWS_ENDPOINT']}",
      path_style: true
    }
    config.fog_directory = ENV["AWS_DIRECTORY"]
    config.storage = :fog
  else
    config.storage = :file
  end
end
