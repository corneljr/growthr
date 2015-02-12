class CreateAccountClients < ActiveRecord::Migration
  def change
    create_table :account_clients do |t|
      t.integer :instagram_client_id
      t.integer :instagram_account_id

      t.timestamps
    end
  end
end
