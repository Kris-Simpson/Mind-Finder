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

ActiveRecord::Schema.define(:version => 20130503190517) do

  create_table "answers", :force => true do |t|
    t.string   "answer"
    t.integer  "question_id"
    t.boolean  "is_right_answer"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "passed_tests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "test_id"
    t.integer  "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "question_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.integer  "test_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "question_type_id"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "parent_id"
    t.boolean  "is_main"
  end

  create_table "tests", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "room_id"
    t.integer  "max_shewn_questions"
    t.integer  "min_shewn_questions"
    t.integer  "max_shewn_answers"
    t.integer  "min_shewn_answers"
    t.integer  "time_for_passing"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                    :null => false
    t.string   "password_digest",          :null => false
    t.string   "last_ip"
    t.boolean  "is_admin"
    t.string   "email_confirmation_token"
    t.string   "reset_password_token"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "locale",                   :null => false
    t.string   "auth_token",               :null => false
  end

end
