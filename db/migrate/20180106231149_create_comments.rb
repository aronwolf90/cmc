class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :issue
      t.text       :content

      t.timestamps
    end
  end
end
