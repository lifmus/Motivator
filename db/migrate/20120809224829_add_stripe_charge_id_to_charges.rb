class AddStripeChargeIdToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :stripe_charge_id, :string
  end
end
