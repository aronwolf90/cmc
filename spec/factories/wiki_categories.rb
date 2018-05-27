# frozen_string_literal: true

FactoryBot.define do
  factory :wiki_category do
    sequence(:title) { |n| "wiki categorie title #{n}"  }
  end
end
