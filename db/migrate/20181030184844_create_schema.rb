class CreateSchema < ActiveRecord::Migration[5.1]
  def up
    drop_table :schema_migrations
    drop_table :ar_internal_metadata
    ActiveRecord::Base.connection.execute(IO.read(Rails.root.join("db/structure.sql")))
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE schema_migrations")
  end
end
