# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_16_000844) do
  create_table "constraints", force: :cascade do |t|
    t.integer "duration"
    t.datetime "due_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contraints", force: :cascade do |t|
    t.datetime "dueTime"
    t.datetime "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "task_id"
    t.index ["task_id"], name: "index_events_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.integer "priority"
    t.decimal "completed_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "constraints_id"
    t.index ["constraints_id"], name: "index_tasks_on_constraints_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "events", "tasks"
  add_foreign_key "tasks", "constraints", column: "constraints_id"
  add_foreign_key "tasks", "users"
end
