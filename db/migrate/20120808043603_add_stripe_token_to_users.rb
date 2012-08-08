class AddStripeTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripeToken, :string
  end
end
