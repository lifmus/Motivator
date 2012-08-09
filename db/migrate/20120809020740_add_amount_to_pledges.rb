class AddAmountToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :amount, :integer
  end
end
