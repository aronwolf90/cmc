class AddMainResponsableToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :main_responsable, foreign_key: { to_table: :users }
  end
end
