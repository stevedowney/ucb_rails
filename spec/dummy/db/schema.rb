# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130614154240) do

  create_table "announcements", :force => true do |t|
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "active"
    t.text     "roles"
    t.text     "types"
    t.text     "style"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hidden_announcements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "announcement_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "hidden_announcements", ["announcement_id"], :name => "index_hidden_announcements_on_announcement_id"
  add_index "hidden_announcements", ["user_id"], :name => "index_hidden_announcements_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "uid",             :limit => 10,                     :null => false
    t.string   "first_name",      :limit => 60
    t.string   "last_name",       :limit => 60
    t.string   "first_last_name", :limit => 100
    t.string   "email",           :limit => 256
    t.string   "phone",           :limit => 30
    t.boolean  "inactive",                       :default => false, :null => false
    t.boolean  "admin",                          :default => false, :null => false
    t.datetime "last_login_at"
    t.datetime "last_request_at"
    t.datetime "last_logout_at"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true

end
