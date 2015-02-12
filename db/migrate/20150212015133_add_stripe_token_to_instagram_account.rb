class AddStripeTokenToInstagramAccount < ActiveRecord::Migration
  def change
  	add_column :instagram_accounts, :stripe_token, :string
  end
end
