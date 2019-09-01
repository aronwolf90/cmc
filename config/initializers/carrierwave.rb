# frozen_string_literal: true

CarrierWave.configure do |config|
  if ENV["AWS_ENABLED"].present?
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["AWS_KEY"],
      aws_secret_access_key: ENV["AWS_SECRET"],
      region: ENV["AWS_REGION"],
      endpoint: ENV['AWS_ENDPOINT'],
      path_style: true
    }.compact
    config.fog_directory = ENV["AWS_DIRECTORY"] || "cmc/#{Rails.env}"
    config.storage = :fog
  else
    config.storage = :file
  end
end
