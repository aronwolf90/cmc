class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :subject
      t.text :body
      t.string :path

      t.timestamps
    end
  end
end
