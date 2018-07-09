# frozen_string_literal: true

FactoryBot.define do
  factory :user_issue do
    spent_time 60.seconds
    start_time 1.hour.ago
    association :user
    association :issue
  end
end
