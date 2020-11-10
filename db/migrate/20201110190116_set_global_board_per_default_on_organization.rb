class SetGlobalBoardPerDefaultOnOrganization < ActiveRecord::Migration[5.1]
  def change
    change_column :organizations, :global_board, :boolean, default: true
  end
end
