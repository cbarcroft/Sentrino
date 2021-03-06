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

ActiveRecord::Schema.define(:version => 20130418234118) do

  create_table "action_types", :force => true do |t|
    t.string   "name"
    t.string   "method"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "actions", :force => true do |t|
    t.integer  "device_id"
    t.integer  "action_type_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "device_actions", :force => true do |t|
    t.string   "nickname"
    t.integer  "actiontype_id"
    t.integer  "device_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "nickname"
    t.string   "model"
    t.string   "ip"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "port"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "log", :force => true do |t|
    t.integer  "user_id"
    t.text     "log_text"
    t.string   "log_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sensor_types", :force => true do |t|
    t.string   "name"
    t.string   "method"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sensors", :force => true do |t|
    t.integer  "device_id"
    t.integer  "sensor_type_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "task_actions", :force => true do |t|
    t.integer  "task_id"
    t.integer  "action_id"
    t.string   "parameters"
    t.string   "post_action"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "task_sensors", :force => true do |t|
    t.integer  "task_id"
    t.integer  "sensor_id"
    t.string   "post_action"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.string   "frequency"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "log_type"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
