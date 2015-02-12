class CreateInstagramClients < ActiveRecord::Migration
  def change
    create_table :instagram_clients do |t|
      t.string :client_id
      t.string :client_secret
      t.boolean :used, default: false

      t.timestamps
    end
  end
end
