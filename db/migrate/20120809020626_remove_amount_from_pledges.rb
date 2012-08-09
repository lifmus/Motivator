class RemoveAmountFromPledges < ActiveRecord::Migration
  def up
    remove_column :pledges, :amount
  end

  def down
    add_column :pledges, :amount, :decimal
  end
end
