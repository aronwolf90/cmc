# frozen_string_literal: true

FactoryBot.define do
  factory :wiki_page do
    title { "wiki page title" }
    content { "wiki page content" }
  end
end
