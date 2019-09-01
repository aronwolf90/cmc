# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    name { "document.txt" }
    document_file { create(:document_file) }

    association :folder
  end
end
