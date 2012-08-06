class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.integer :goal_id
      t.string :description
      t.integer :frequency

      t.timestamps
    end
  end
end
