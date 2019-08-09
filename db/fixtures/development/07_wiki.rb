# frozen_string_literal: true

WikiCategory.seed do |s|
  s.id    = 1
  s.title = "category 1"
end

WikiCategory.seed do |s|
  s.id    = 2
  s.title = "subcategory 1"
  s.wiki_category_id = 1
end

WikiCategory.seed do |s|
  s.id    = 3
  s.title = "subcategory 2"
  s.wiki_category_id = 1
end

WikiPage.seed do |s|
  s.id = 1
  s.wiki_category_id = 3
  s.title = "wiki page title"
  s.content = "test content"
end
