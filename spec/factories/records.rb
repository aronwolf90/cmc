# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    start_time { "2018-01-29 20:09:37" }
    end_time { "2018-01-29 20:10:37" }
    association :issue
    association :user, factory: :admin
  end
end
