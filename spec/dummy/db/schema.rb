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

ActiveRecord::Schema.define(:version => 20120221154551) do

  create_table "census_answers", :force => true do |t|
    t.integer "question_id"
    t.integer "user_id"
    t.string  "data"
  end

  add_index "census_answers", ["question_id"], :name => "idx_answrs_qstnid"
  add_index "census_answers", ["user_id"], :name => "idx_answrs_usrid"

  create_table "census_choices", :force => true do |t|
    t.integer  "question_id"
    t.string   "value"
    t.integer  "position"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "census_choices", ["question_id"], :name => "idx_choices_qstnid"

  create_table "census_data_groups", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "census_questions", :force => true do |t|
    t.integer  "data_group_id"
    t.string   "data_type"
    t.string   "prompt"
    t.boolean  "multiple"
    t.boolean  "other"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "census_questions", ["data_group_id"], :name => "idx_qstns_datagrpid"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
