class AddNameToStep < ActiveRecord::Migration
  def change
    add_column :steps, :name, :string
  end
end
