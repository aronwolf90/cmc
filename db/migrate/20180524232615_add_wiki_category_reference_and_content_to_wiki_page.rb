class AddWikiCategoryReferenceAndContentToWikiPage < ActiveRecord::Migration[5.1]
  def change
    add_reference :wiki_pages, :wiki_category, index: true, foreigen_key: true, null: false
    add_column :wiki_pages, :content, :text
  end
end
