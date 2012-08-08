class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :goal_id
      t.decimal :amount

      t.timestamps
    end
  end
end
