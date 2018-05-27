class CreateWikiCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :wiki_categories do |t|
      t.string :title, blank: false
      t.references :wiki_category, index: true, foreigen_key: true

      t.timestamps
    end
  end
end
