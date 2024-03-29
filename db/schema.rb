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

ActiveRecord::Schema[7.0].define(version: 2023_11_24_154223) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "cooking_methods", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
    t.index ["name"], name: "index_cooking_methods_on_name", unique: true
    t.index ["name_en"], name: "index_cooking_methods_on_name_en", unique: true
  end

  create_table "dish_attributes", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
  end

  create_table "dishes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "seasoning_id", null: false
    t.bigint "texture_id", null: false
    t.bigint "category_id", null: false
    t.string "uuid"
    t.string "dish_name"
    t.string "point"
    t.string "dish_image"
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_dishes_on_category_id"
    t.index ["seasoning_id"], name: "index_dishes_on_seasoning_id"
    t.index ["texture_id"], name: "index_dishes_on_texture_id"
    t.index ["user_id"], name: "index_dishes_on_user_id"
    t.index ["uuid"], name: "index_dishes_on_uuid", unique: true
  end

  create_table "dishes_cooking_methods", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "cooking_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cooking_method_id"], name: "index_dishes_cooking_methods_on_cooking_method_id"
    t.index ["dish_id", "cooking_method_id"], name: "index_dishes_cooking_methods_on_dish_id_and_cooking_method_id", unique: true
    t.index ["dish_id"], name: "index_dishes_cooking_methods_on_dish_id"
  end

  create_table "dishes_ingredients", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id", "ingredient_id"], name: "index_dishes_ingredients_on_dish_id_and_ingredient_id", unique: true
    t.index ["dish_id"], name: "index_dishes_ingredients_on_dish_id"
    t.index ["ingredient_id"], name: "index_dishes_ingredients_on_ingredient_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", null: false
    t.string "morphemes", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_likes_on_dish_id"
    t.index ["user_id", "dish_id"], name: "index_likes_on_user_id_and_dish_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "avatar"
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "dishes", "users"
  add_foreign_key "dishes_cooking_methods", "cooking_methods"
  add_foreign_key "dishes_cooking_methods", "dishes"
  add_foreign_key "dishes_ingredients", "dishes"
  add_foreign_key "dishes_ingredients", "ingredients"
  add_foreign_key "likes", "dishes"
  add_foreign_key "likes", "users"
end
