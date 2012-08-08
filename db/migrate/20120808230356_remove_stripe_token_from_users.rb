class RemoveStripeTokenFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :stripeToken
  end

  def down
    add_column :users, :stripeToken, :string
  end
end
