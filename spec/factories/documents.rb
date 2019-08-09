# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    name "document.txt"
    file do
      Rack::Test::UploadedFile.new(
        Rails.root.join("spec", "fixtures", "document.txt")
      )
    end
    association :folder
  end
end
