class CreateUserAnnouncementTables < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :message
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :active
      t.text :roles
      t.text :types
      t.text :style
      t.timestamps
    end
    
    create_table :hidden_announcements, :force => true do |t|
      t.integer :user_id
      t.integer :announcement_id
      t.timestamps
    end
    
    add_index :hidden_announcements, :user_id
    add_index :hidden_announcements, :announcement_id
  end
end