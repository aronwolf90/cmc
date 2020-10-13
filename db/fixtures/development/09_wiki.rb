# frozen_string_literal: true

WikiCategory.bulk_insert(
  :id,
  :title,
  :wiki_category_id,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    title: "category 1",
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 2,
    title: "subcategory 1",
    wiki_category_id: 1,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 3,
    title: "subcategory 2",
    wiki_category_id: 1,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end

WikiPage.seed do |s|
  s.id = 1
  s.wiki_category_id = 3
  s.title = "wiki page title"
  s.content = "test content"
end
