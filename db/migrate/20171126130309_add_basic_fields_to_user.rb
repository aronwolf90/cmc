class AddBasicFieldsToUser < ActiveRecord::Migration[5.1]
  def up
    change_table :users do |t|
      t.string  :firstname
      t.string  :lastname
      t.integer :gender
    end
  end

  def down
    change_table :users do |t|
      t.remove :firstname
      t.remove :lastname
      t.remove :gender
    end
  end
end
