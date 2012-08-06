class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :objective_id
      t.datetime :completed_at

      t.timestamps
    end
  end
end
