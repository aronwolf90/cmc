# frozen_string_literal: true

FactoryBot.define do
  factory :document_file do
    file do
      Rack::Test::UploadedFile.new(
        Rails.root.join("spec", "fixtures", "document.txt")
      )
    end
  end
end
