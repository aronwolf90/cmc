# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person-#{n}@example.com" }
    firstname "firstname"
    lastname "lastname"
    password "testtest"
  end
end
