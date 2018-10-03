# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person-#{n}@example.com" }
    firstname "firstname"
    lastname "lastname"
    password "testtest"
    invitation_created_at Time.zone.now

    avatar do
      Rack::Test::UploadedFile.new(
        Rails.root.join("spec", "fixures", "image.png")
      )
    end

    factory :admin, class: Admin
    factory :employee, class: Employee
    factory :customer, class: Customer
  end
end
