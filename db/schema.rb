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

ActiveRecord::Schema.define(version: 20180902142751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordinal_number"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_board_lists_on_project_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "issue_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["issue_id"], name: "index_comments_on_issue_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name", null: false
    t.string "file", null: false
    t.bigint "folder_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_documents_on_folder_id"
  end

  create_table "folders", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_folders_on_folder_id"
  end

  create_table "issues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.text "description"
    t.bigint "user_id"
    t.decimal "complexity", precision: 2, scale: 1
    t.integer "board_list_id", null: false
    t.integer "ordinal_number"
    t.index ["board_list_id"], name: "index_issues_on_board_list_id"
    t.index ["user_id"], name: "index_issues_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone", null: false
    t.integer "time_zone_seconds"
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id"
    t.bigint "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_records_on_issue_id"
    t.index ["user_id"], name: "index_records_on_user_id"
    t.index ["user_id"], name: "unique_active_record_per_user", unique: true, where: "(end_time IS NULL)"
  end

  create_table "user_projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "firstname"
    t.string "lastname"
    t.integer "gender"
    t.string "avatar"
    t.integer "selected_project_id"
    t.string "telephone_number"
    t.string "type", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["selected_project_id"], name: "index_users_on_selected_project_id"
  end

  create_table "wiki_categories", force: :cascade do |t|
    t.string "title"
    t.bigint "wiki_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wiki_category_id"], name: "index_wiki_categories_on_wiki_category_id"
  end

  create_table "wiki_pages", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wiki_category_id", null: false
    t.text "content"
    t.index ["wiki_category_id"], name: "index_wiki_pages_on_wiki_category_id"
  end

  add_foreign_key "board_lists", "projects"
  add_foreign_key "comments", "users"
  add_foreign_key "documents", "folders"
  add_foreign_key "folders", "folders"
  add_foreign_key "issues", "board_lists"
  add_foreign_key "records", "issues", on_delete: :nullify
  add_foreign_key "records", "users"
  add_foreign_key "users", "projects", column: "selected_project_id"

  create_view "user_issues",  sql_definition: <<-SQL
      SELECT users.id AS user_id,
      issues.id AS issue_id,
      sum((records.end_time - records.start_time)) AS spent_time,
      min(records.start_time) AS start_time
     FROM ((users
       JOIN records ON ((records.user_id = users.id)))
       JOIN issues ON ((issues.id = records.issue_id)))
    GROUP BY users.id, issues.id;
  SQL

  create_view "record_days",  sql_definition: <<-SQL
      SELECT ((records.start_time + ((organizations.time_zone_seconds)::double precision * 'PT1S'::interval)))::date AS day,
      records.user_id
     FROM (records
       JOIN public.organizations ON (((organizations.name)::name = "current_schema"())))
    GROUP BY (((records.start_time + ((organizations.time_zone_seconds)::double precision * 'PT1S'::interval)))::date), records.user_id;
  SQL

  create_view "project_record_days",  sql_definition: <<-SQL
      SELECT ((records.start_time + ((organizations.time_zone_seconds)::double precision * 'PT1S'::interval)))::date AS day,
      board_lists.project_id
     FROM (((records
       JOIN issues ON ((issues.id = records.issue_id)))
       JOIN board_lists ON ((board_lists.id = issues.board_list_id)))
       JOIN public.organizations ON (((organizations.name)::name = "current_schema"())))
    GROUP BY (((records.start_time + ((organizations.time_zone_seconds)::double precision * 'PT1S'::interval)))::date), board_lists.project_id;
  SQL

end
