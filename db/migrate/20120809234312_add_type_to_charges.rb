class AddTypeToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :transaction_type, :string
  end
end
