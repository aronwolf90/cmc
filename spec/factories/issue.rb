# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    title { "title" }
    description { "description" }

    association :board_list
  end
end
