class CreateInstagramAccounts < ActiveRecord::Migration
  def change
    create_table :instagram_accounts do |t|
      t.string :username
      t.string :access_token
      t.string :hashtag

      t.timestamps
    end
  end
end
