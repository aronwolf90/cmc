ActiveRecord::Base.connection.execute(IO.read(Rails.root.join("db/structure.sql")))
