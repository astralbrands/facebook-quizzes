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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130819163447) do

  create_table "answers", force: true do |t|
    t.string   "content"
    t.integer  "category_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["category_id"], name: "index_answers_on_category_id"
  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "categories", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quiz_id"
    t.string   "display_img_file_name"
    t.string   "display_img_content_type"
    t.integer  "display_img_file_size"
    t.datetime "display_img_updated_at"
    t.string   "share_img_file_name"
    t.string   "share_img_content_type"
    t.integer  "share_img_file_size"
    t.datetime "share_img_updated_at"
  end

  add_index "categories", ["quiz_id"], name: "index_categories_on_quiz_id"

  create_table "questions", force: true do |t|
    t.string   "text"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["quiz_id"], name: "index_questions_on_quiz_id"

  create_table "quizzes", force: true do |t|
    t.text     "intro"
    t.string   "name"
    t.string   "slug"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "product_img_file_name"
    t.string   "product_img_content_type"
    t.integer  "product_img_file_size"
    t.datetime "product_img_updated_at"
    t.text     "product_copy"
  end

end
