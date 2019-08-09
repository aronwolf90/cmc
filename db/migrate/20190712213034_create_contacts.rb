# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :description
      t.string :telephone
      t.string :mobile
      t.string :fax
      t.string :address_city
      t.string :address_zip
      t.string :address_street
      t.string :address_number
      t.string :address_country
      t.belongs_to :contact_avatar

      t.timestamps
    end
  end
end
