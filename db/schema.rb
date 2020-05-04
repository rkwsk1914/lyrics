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

ActiveRecord::Schema.define(version: 2020_05_04_064920) do

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "lyric_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lyric_id"], name: "index_favorites_on_lyric_id"
    t.index ["user_id", "lyric_id"], name: "index_favorites_on_user_id_and_lyric_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "lyrics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "comment"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lyrics_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "talkroom_id"
    t.boolean "read"
    t.index ["talkroom_id"], name: "index_messages_on_talkroom_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "talkrooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "roommate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roommate_id"], name: "index_talkrooms_on_roommate_id"
    t.index ["user_id", "roommate_id"], name: "index_talkrooms_on_user_id_and_roommate_id", unique: true
    t.index ["user_id"], name: "index_talkrooms_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "profile"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
  end

  add_foreign_key "favorites", "lyrics"
  add_foreign_key "favorites", "users"
  add_foreign_key "lyrics", "users"
  add_foreign_key "messages", "talkrooms"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
  add_foreign_key "talkrooms", "users"
  add_foreign_key "talkrooms", "users", column: "roommate_id"
end
