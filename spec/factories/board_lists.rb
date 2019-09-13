# frozen_string_literal: true

FactoryBot.define do
  factory :board_list do
    name { "name" }

    association :project
  end
end
