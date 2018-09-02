# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    name "test-organization"
    time_zone "Berlin"
    time_zone_seconds 7200
  end
end
