# frozen_string_literal: true

if ENV["AWS_KEY"].present?
  CarrierWave.configure do |config|
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
  end
end
