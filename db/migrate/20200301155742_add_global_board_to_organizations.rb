class AddGlobalBoardToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :global_board, :boolean, null: false, default: false
  end
end
