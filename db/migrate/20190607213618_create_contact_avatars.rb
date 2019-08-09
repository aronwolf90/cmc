class CreateContactAvatars < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_avatars do |t|
      t.string :file

      t.timestamps
    end
  end
end
