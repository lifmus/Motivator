class AddRefundedAtToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :refunded_at, :datetime
  end
end
