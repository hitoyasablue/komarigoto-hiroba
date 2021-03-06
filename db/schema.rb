# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_28_060823) do

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "customer_id", null: false
    t.string "card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "erais", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "progress_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["progress_id"], name: "index_erais_on_progress_id"
    t.index ["user_id", "progress_id"], name: "index_erais_on_user_id_and_progress_id", unique: true
    t.index ["user_id"], name: "index_erais_on_user_id"
  end

  create_table "gifts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "customer_id", null: false
    t.string "card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id", "post_id"], name: "index_likes_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "post_id"
    t.integer "progress_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_notifications_on_post_id"
    t.index ["progress_id"], name: "index_notifications_on_progress_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "ouen2s", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "progress_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["progress_id"], name: "index_ouen2s_on_progress_id"
    t.index ["user_id", "progress_id"], name: "index_ouen2s_on_user_id_and_progress_id", unique: true
    t.index ["user_id"], name: "index_ouen2s_on_user_id"
  end

  create_table "ouens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_ouens_on_post_id"
    t.index ["user_id", "post_id"], name: "index_ouens_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_ouens_on_user_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.text "optional_content"
    t.text "optional_content_2"
    t.text "optional_content_3"
    t.text "optional_content_4"
    t.text "optional_content_5"
    t.text "optional_content_6"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "progresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "optional_content"
    t.text "optional_content_2"
    t.text "optional_content_3"
    t.text "optional_content_4"
    t.text "content_2"
    t.index ["post_id"], name: "index_progresses_on_post_id"
  end

  create_table "sounandas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "progress_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["progress_id"], name: "index_sounandas_on_progress_id"
    t.index ["user_id", "progress_id"], name: "index_sounandas_on_user_id_and_progress_id", unique: true
    t.index ["user_id"], name: "index_sounandas_on_user_id"
  end

  create_table "teinei2s", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "progress_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["progress_id"], name: "index_teinei2s_on_progress_id"
    t.index ["user_id", "progress_id"], name: "index_teinei2s_on_user_id_and_progress_id", unique: true
    t.index ["user_id"], name: "index_teinei2s_on_user_id"
  end

  create_table "teineis", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_teineis_on_post_id"
    t.index ["user_id", "post_id"], name: "index_teineis_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_teineis_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "image"
    t.string "access_code"
    t.string "publishable_key"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wakarus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_wakarus_on_post_id"
    t.index ["user_id", "post_id"], name: "index_wakarus_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_wakarus_on_user_id"
  end

  add_foreign_key "progresses", "posts"
end
