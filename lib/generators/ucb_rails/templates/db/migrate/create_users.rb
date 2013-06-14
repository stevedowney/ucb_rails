class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :force => true do |t|
      t.string :uid, :null => false, :limit => 10
      t.string :first_name, :limit => 60
      t.string :last_name, :limit => 60
      t.string :first_last_name, :limit => 100
      t.string :email, :limit => 256
      t.string :phone, :limit => 30
      t.boolean :inactive, :null => false, :default => false
      t.boolean :admin, :null => false, :default => false
      t.datetime :last_login_at
      t.datetime :last_request_at
      t.datetime :last_logout_at
      t.timestamps
    end
    
    add_index :users, :uid, :unique => true
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :email
  end
end
