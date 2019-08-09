# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    name { "Frantz" }
    address_zip { "86153" }
    address_country { "germany" }
    address_street { "Street" }
    address_number { "8" }
  end
end
