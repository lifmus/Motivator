class AddPublicToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :public, :boolean, :default => false
  end
end
