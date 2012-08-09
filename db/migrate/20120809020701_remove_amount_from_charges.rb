class RemoveAmountFromCharges < ActiveRecord::Migration
  def up
    remove_column :charges, :amount
  end

  def down
    add_column :charges, :amount, :decimal
  end
end
