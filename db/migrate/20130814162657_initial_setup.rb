class InitialSetup < ActiveRecord::Migration
  def change
    create_table "answers", force: true do |t|
      t.string   "content"
      t.integer  "category_id"
      t.integer  "question_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "answers", ["question_id"], name: "index_answers_on_question_id"
    add_index "answers", ["category_id"], name: "index_answers_on_category_id"

    create_table "categories", force: true do |t|
      t.string   "title"
      t.text     "text"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "quiz_id"
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
    end
  end
end