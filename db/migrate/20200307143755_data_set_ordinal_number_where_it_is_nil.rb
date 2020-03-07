class DataSetOrdinalNumberWhereItIsNil < ActiveRecord::Migration[5.1]
  def data
    Issue
      .where(ordinal_number: nil)
      .update_all(ordinal_number: 0)
    Issue
      .where(global_ordinal_number: nil)
      .update_all(global_ordinal_number: 0)
  end
end
