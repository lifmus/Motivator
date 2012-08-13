class AddRefundedBackToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :refunded_back, :integer, :default => 0
  end
end
