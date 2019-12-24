class AddDefaultValueToOrdinalValue < ActiveRecord::Migration[5.1]
  def change
     change_column_default :issues, :ordinal_number, from: nil, to: 0
  end
end
