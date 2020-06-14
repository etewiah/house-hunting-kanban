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

ActiveRecord::Schema.define(version: 2020_01_08_101911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "access_invitations", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.uuid "guest_uuid"
    t.uuid "user_uuid"
    t.uuid "invited_by_guest_uuid"
    t.uuid "invited_by_user_uuid"
    t.uuid "content_uuid"
    t.string "invitee_nickname"
    t.integer "invitation_state", default: 0, null: false
    t.integer "flags", default: 0, null: false
    t.integer "access_level", default: 0, null: false
    t.integer "edit_role", default: 0, null: false
    t.datetime "invited_at"
    t.datetime "invitation_accepted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_level"], name: "index_access_invitations_on_access_level"
    t.index ["edit_role"], name: "index_access_invitations_on_edit_role"
    t.index ["flags"], name: "index_access_invitations_on_flags"
    t.index ["invitation_state"], name: "index_access_invitations_on_invitation_state"
  end

  create_table "access_tokens", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.uuid "guest_uuid"
    t.uuid "user_uuid"
    t.uuid "invited_by_guest_uuid"
    t.uuid "invited_by_user_uuid"
    t.uuid "content_uuid"
    t.string "invitee_nickname"
    t.boolean "is_creator_token", default: false
    t.integer "invitation_state", default: 0, null: false
    t.integer "flags", default: 0, null: false
    t.integer "access_level", default: 0, null: false
    t.integer "edit_role", default: 0, null: false
    t.datetime "last_accessed_at"
    t.datetime "valid_from"
    t.datetime "valid_till"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_level"], name: "index_access_tokens_on_access_level"
    t.index ["edit_role"], name: "index_access_tokens_on_edit_role"
    t.index ["flags"], name: "index_access_tokens_on_flags"
    t.index ["invitation_state"], name: "index_access_tokens_on_invitation_state"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.uuid "user_uuid"
    t.uuid "guest_uuid"
    t.uuid "content_uuid"
    t.uuid "access_token_uuid"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.uuid "user_uuid"
    t.uuid "guest_uuid"
    t.string "host"
    t.integer "flags", default: 0, null: false
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "content_comments", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.integer "flags", default: 0, null: false
    t.datetime "discarded_at"
    t.uuid "guest_uuid"
    t.uuid "access_token_uuid"
    t.uuid "user_uuid"
    t.uuid "content_uuid"
    t.text "raw"
    t.text "cooked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flags"], name: "index_content_comments_on_flags"
  end

  create_table "contents", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.uuid "authentication_token", default: -> { "gen_random_uuid()" }
    t.integer "flags", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "views_count", default: 0, null: false
    t.boolean "is_private", default: false
    t.boolean "is_secured", default: false
    t.boolean "is_published", default: false
    t.integer "anon_access_level", default: 0, null: false
    t.integer "anon_edit_role", default: 0, null: false
    t.text "raw"
    t.text "cooked"
    t.string "url"
    t.string "slug"
    t.text "description"
    t.string "title"
    t.string "sha1"
    t.string "sha256"
    t.string "other_hash"
    t.integer "other_hash_type", default: 0
    t.datetime "visible_from"
    t.datetime "visible_till"
    t.datetime "to_destroy_at"
    t.datetime "to_discard_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["anon_access_level"], name: "index_contents_on_anon_access_level"
    t.index ["anon_edit_role"], name: "index_contents_on_anon_edit_role"
    t.index ["flags"], name: "index_contents_on_flags"
    t.index ["status"], name: "index_contents_on_status"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "flags", default: 0, null: false
    t.string "title"
    t.string "name"
    t.string "email"
    t.boolean "can_be_contacted"
    t.text "positive"
    t.text "negative"
    t.text "other"
    t.string "origin_ip"
    t.string "user_agent"
    t.float "longitude"
    t.float "latitude"
    t.string "locale"
    t.string "host"
    t.string "url"
    t.string "project_uuid"
    t.integer "user_id"
    t.json "details", default: {}
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_feedbacks_on_discarded_at"
    t.index ["flags"], name: "index_feedbacks_on_flags"
  end

  create_table "guests", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.uuid "authentication_token", default: -> { "gen_random_uuid()" }
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_names"
    t.string "last_names"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notes", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.string "project_uuid"
    t.integer "flags", default: 0, null: false
    t.integer "sale_listing_id"
    t.integer "rental_listing_id"
    t.integer "user_id"
    t.string "title"
    t.json "details", default: {}
    t.jsonb "translations", default: {}
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_notes_on_discarded_at"
    t.index ["flags"], name: "index_notes_on_flags"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.binary "metadata"
    t.integer "flags", default: 0, null: false
    t.json "details", default: {}
    t.jsonb "translations", default: {}
    t.datetime "discarded_at"
    t.jsonb "categories", default: {}, null: false
    t.string "city_search_key", default: "", null: false
    t.json "related_urls", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories"], name: "index_projects_on_categories", using: :gin
    t.index ["city_search_key"], name: "index_projects_on_city_search_key"
    t.index ["discarded_at"], name: "index_projects_on_discarded_at"
    t.index ["flags"], name: "index_projects_on_flags"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "realty_assets", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.string "reference"
    t.string "title"
    t.text "description"
    t.integer "year_construction", default: 0, null: false
    t.integer "count_bedrooms", default: 0, null: false
    t.float "count_bathrooms", default: 0.0, null: false
    t.integer "count_toilets", default: 0, null: false
    t.integer "count_garages", default: 0, null: false
    t.float "plot_area", default: 0.0, null: false
    t.float "constructed_area", default: 0.0, null: false
    t.integer "area_unit", default: 0
    t.integer "energy_rating"
    t.float "energy_performance"
    t.integer "flags", default: 0, null: false
    t.string "prop_origin_key", default: "", null: false
    t.string "prop_state_key", default: "", null: false
    t.string "prop_type_key", default: "", null: false
    t.string "street_number"
    t.string "street_name"
    t.string "street_address"
    t.string "postal_code"
    t.string "province"
    t.string "city"
    t.string "city_search_key", default: "", null: false
    t.string "region"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.string "floor"
    t.json "details", default: {}
    t.string "neighborhood"
    t.string "neighborhood_search_key", default: "", null: false
    t.string "import_url"
    t.string "google_place_id"
    t.jsonb "translations", default: {}
    t.jsonb "categories", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories"], name: "index_realty_assets_on_categories", using: :gin
    t.index ["city_search_key"], name: "index_realty_assets_on_city_search_key"
    t.index ["constructed_area"], name: "index_realty_assets_on_constructed_area"
    t.index ["count_bathrooms"], name: "index_realty_assets_on_count_bathrooms"
    t.index ["count_bedrooms"], name: "index_realty_assets_on_count_bedrooms"
    t.index ["count_garages"], name: "index_realty_assets_on_count_garages"
    t.index ["count_toilets"], name: "index_realty_assets_on_count_toilets"
    t.index ["latitude", "longitude"], name: "index_realty_assets_on_latitude_and_longitude"
    t.index ["neighborhood_search_key"], name: "index_realty_assets_on_neighborhood_search_key"
    t.index ["plot_area"], name: "index_realty_assets_on_plot_area"
    t.index ["reference"], name: "index_realty_assets_on_reference"
  end

  create_table "rental_listing_photos", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.integer "rental_listing_id"
    t.string "image"
    t.string "description"
    t.string "folder", default: "weebrix"
    t.integer "file_size"
    t.json "process_options", default: {}
    t.string "height"
    t.string "width"
    t.string "content_type"
    t.integer "sort_order"
    t.jsonb "translations", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rental_listing_id"], name: "index_rental_listing_photos_on_rental_listing_id"
  end

  create_table "rental_listings", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.string "reference"
    t.integer "flags", default: 0, null: false
    t.boolean "furnished", default: false
    t.boolean "reserved", default: false
    t.boolean "highlighted", default: false
    t.boolean "archived", default: false
    t.boolean "visible", default: false
    t.boolean "for_rent_daily", default: false
    t.boolean "for_rent_monthly", default: false
    t.boolean "for_rent_long_term", default: false
    t.boolean "hide_map", default: false
    t.boolean "obscure_map", default: false
    t.datetime "available_from"
    t.datetime "available_till"
    t.integer "occupants"
    t.integer "units"
    t.string "main_video_url"
    t.json "details"
    t.datetime "publish_from"
    t.datetime "publish_till"
    t.integer "realty_asset_id"
    t.jsonb "translations", default: {}
    t.datetime "discarded_at"
    t.integer "price_rental_monthly_low_season_cents", default: 0, null: false
    t.string "price_rental_monthly_low_season_currency", default: "USD", null: false
    t.integer "price_rental_monthly_high_season_cents", default: 0, null: false
    t.string "price_rental_monthly_high_season_currency", default: "USD", null: false
    t.integer "price_rental_monthly_standard_season_cents", default: 0, null: false
    t.string "price_rental_monthly_standard_season_currency", default: "USD", null: false
    t.integer "price_rental_daily_low_season_cents", default: 0, null: false
    t.string "price_rental_daily_low_season_currency", default: "USD", null: false
    t.integer "price_rental_daily_high_season_cents", default: 0, null: false
    t.string "price_rental_daily_high_season_currency", default: "USD", null: false
    t.integer "price_rental_daily_standard_season_cents", default: 0, null: false
    t.string "price_rental_daily_standard_season_currency", default: "USD", null: false
    t.integer "commission_cents", default: 0, null: false
    t.string "commission_currency", default: "USD", null: false
    t.integer "service_charge_yearly_cents", default: 0, null: false
    t.string "service_charge_yearly_currency", default: "USD", null: false
    t.integer "price_rental_monthly_for_search_cents", default: 0, null: false
    t.string "price_rental_monthly_for_search_currency", default: "USD", null: false
    t.integer "price_rental_daily_for_search_cents", default: 0, null: false
    t.string "price_rental_daily_for_search_currency", default: "USD", null: false
    t.string "currency"
    t.string "import_url"
    t.json "related_urls", default: {}
    t.integer "capacity"
    t.text "schedule"
    t.string "project_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_rental_listings_on_discarded_at"
    t.index ["flags"], name: "index_rental_listings_on_flags"
    t.index ["for_rent_daily"], name: "index_rental_listings_on_for_rent_daily"
    t.index ["for_rent_long_term"], name: "index_rental_listings_on_for_rent_long_term"
    t.index ["for_rent_monthly"], name: "index_rental_listings_on_for_rent_monthly"
    t.index ["highlighted"], name: "index_rental_listings_on_highlighted"
    t.index ["occupants"], name: "index_rental_listings_on_occupants"
    t.index ["price_rental_daily_for_search_cents"], name: "index_rental_listings_on_price_rental_daily_for_search_cents"
    t.index ["price_rental_monthly_for_search_cents"], name: "index_rental_listings_on_price_rental_monthly_for_search_cents"
    t.index ["reference"], name: "index_rental_listings_on_reference"
    t.index ["units"], name: "index_rental_listings_on_units"
    t.index ["visible"], name: "index_rental_listings_on_visible"
  end

  create_table "sale_listing_photos", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.integer "sale_listing_id"
    t.string "image"
    t.string "description"
    t.string "folder", default: "weebrix"
    t.integer "file_size"
    t.json "process_options", default: {}
    t.string "height"
    t.string "width"
    t.string "content_type"
    t.integer "sort_order"
    t.jsonb "translations", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_listing_id"], name: "index_sale_listing_photos_on_sale_listing_id"
  end

  create_table "sale_listings", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.string "reference"
    t.integer "flags", default: 0, null: false
    t.boolean "furnished", default: false
    t.boolean "reserved", default: false
    t.boolean "highlighted", default: false
    t.boolean "archived", default: false
    t.boolean "visible", default: false
    t.boolean "hide_map", default: false
    t.boolean "obscure_map", default: false
    t.string "main_video_url"
    t.json "details"
    t.datetime "publish_from"
    t.datetime "publish_till"
    t.integer "realty_asset_id"
    t.jsonb "translations", default: {}
    t.datetime "discarded_at"
    t.integer "price_sale_current_cents", default: 0, null: false
    t.string "price_sale_current_currency", default: "USD", null: false
    t.integer "price_sale_original_cents", default: 0, null: false
    t.string "price_sale_original_currency", default: "USD", null: false
    t.integer "commission_cents", default: 0, null: false
    t.string "commission_currency", default: "USD", null: false
    t.integer "service_charge_yearly_cents", default: 0, null: false
    t.string "service_charge_yearly_currency", default: "USD", null: false
    t.string "currency"
    t.string "import_url"
    t.json "related_urls", default: {}
    t.string "project_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_sale_listings_on_discarded_at"
    t.index ["flags"], name: "index_sale_listings_on_flags"
    t.index ["highlighted"], name: "index_sale_listings_on_highlighted"
    t.index ["price_sale_current_cents"], name: "index_sale_listings_on_price_sale_current_cents"
    t.index ["price_sale_original_cents"], name: "index_sale_listings_on_price_sale_original_cents"
    t.index ["reference"], name: "index_sale_listings_on_reference"
    t.index ["visible"], name: "index_sale_listings_on_visible"
  end

  create_table "timelystamp_verifications", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.integer "flags", default: 0, null: false
    t.string "timelystamp_url_hash"
    t.text "body"
    t.string "body_sha256"
    t.text "whole_page"
    t.string "whole_page_sha256"
    t.datetime "timestamped_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["body_sha256"], name: "index_timelystamp_verifications_on_body_sha256"
    t.index ["flags"], name: "index_timelystamp_verifications_on_flags"
    t.index ["timelystamp_url_hash"], name: "index_timelystamp_verifications_on_timelystamp_url_hash"
  end

  create_table "timelystamps", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.integer "flags", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "views_count", default: 0, null: false
    t.boolean "is_private", default: false
    t.boolean "is_secured", default: false
    t.boolean "is_published", default: false
    t.integer "anon_access_level", default: 0, null: false
    t.integer "anon_edit_role", default: 0, null: false
    t.text "body"
    t.string "body_sha256"
    t.text "whole_page"
    t.string "whole_page_sha256"
    t.json "details", default: {}
    t.string "url_without_query"
    t.string "url"
    t.string "url_sha256"
    t.string "url_with_ts_sha256"
    t.string "slug"
    t.text "description"
    t.string "title"
    t.string "other_hash"
    t.integer "other_hash_type", default: 0
    t.datetime "timestamped_at"
    t.datetime "visible_from"
    t.datetime "visible_till"
    t.datetime "to_destroy_at"
    t.datetime "to_discard_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["body_sha256"], name: "index_timelystamps_on_body_sha256"
    t.index ["flags"], name: "index_timelystamps_on_flags"
    t.index ["status"], name: "index_timelystamps_on_status"
    t.index ["url_sha256"], name: "index_timelystamps_on_url_sha256"
    t.index ["url_with_ts_sha256"], name: "index_timelystamps_on_url_with_ts_sha256"
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "authentication_token"
    t.boolean "admin", default: false
    t.string "first_names"
    t.string "last_names"
    t.string "skype"
    t.string "default_client_locale"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.integer "flags", default: 0, null: false
    t.uuid "guest_uuid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["flags"], name: "index_users_on_flags"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end


  create_view "sale_listing_with_assets", sql_definition: <<-SQL
      SELECT sale_listings.project_uuid,
      sale_listings.discarded_at,
      sale_listings.id,
      sale_listings.reference,
      sale_listings.flags,
      sale_listings.furnished,
      sale_listings.reserved,
      sale_listings.highlighted,
      sale_listings.archived,
      sale_listings.visible,
      sale_listings.hide_map,
      sale_listings.obscure_map,
      sale_listings.main_video_url,
      sale_listings.details,
      sale_listings.related_urls,
      sale_listings.publish_from,
      sale_listings.publish_till,
      sale_listings.realty_asset_id,
      sale_listings.translations,
      sale_listings.price_sale_current_cents,
      sale_listings.price_sale_current_currency,
      sale_listings.price_sale_original_cents,
      sale_listings.price_sale_original_currency,
      sale_listings.commission_cents,
      sale_listings.commission_currency,
      sale_listings.service_charge_yearly_cents,
      sale_listings.service_charge_yearly_currency,
      sale_listings.currency,
      sale_listings.import_url,
      sale_listings.created_at,
      sale_listings.updated_at,
      realty_assets.reference AS asset_reference,
      realty_assets.longitude,
      realty_assets.latitude,
      realty_assets.year_construction,
      realty_assets.count_bathrooms,
      realty_assets.count_bedrooms,
      realty_assets.count_toilets,
      realty_assets.count_garages,
      realty_assets.plot_area,
      realty_assets.constructed_area,
      realty_assets.area_unit,
      realty_assets.energy_rating,
      realty_assets.energy_performance,
      realty_assets.street_number,
      realty_assets.street_name,
      realty_assets.street_address,
      realty_assets.postal_code,
      realty_assets.province,
      realty_assets.city,
      realty_assets.city_search_key,
      realty_assets.region,
      realty_assets.country,
      realty_assets.floor,
      realty_assets.neighborhood,
      realty_assets.neighborhood_search_key,
      realty_assets.google_place_id
     FROM sale_listings,
      realty_assets
    WHERE (sale_listings.realty_asset_id = realty_assets.id);
  SQL
  create_view "rental_listing_with_assets", sql_definition: <<-SQL
      SELECT rental_listings.project_uuid,
      rental_listings.discarded_at,
      rental_listings.id,
      rental_listings.reference,
      rental_listings.flags,
      rental_listings.furnished,
      rental_listings.reserved,
      rental_listings.highlighted,
      rental_listings.archived,
      rental_listings.visible,
      rental_listings.hide_map,
      rental_listings.obscure_map,
      rental_listings.main_video_url,
      rental_listings.details,
      rental_listings.related_urls,
      rental_listings.publish_from,
      rental_listings.publish_till,
      rental_listings.realty_asset_id,
      rental_listings.translations,
      rental_listings.commission_cents,
      rental_listings.commission_currency,
      rental_listings.service_charge_yearly_cents,
      rental_listings.service_charge_yearly_currency,
      rental_listings.price_rental_monthly_low_season_cents,
      rental_listings.price_rental_monthly_low_season_currency,
      rental_listings.price_rental_daily_low_season_cents,
      rental_listings.price_rental_daily_low_season_currency,
      rental_listings.price_rental_monthly_high_season_cents,
      rental_listings.price_rental_monthly_high_season_currency,
      rental_listings.price_rental_daily_high_season_cents,
      rental_listings.price_rental_daily_high_season_currency,
      rental_listings.price_rental_monthly_standard_season_cents,
      rental_listings.price_rental_monthly_standard_season_currency,
      rental_listings.price_rental_daily_standard_season_cents,
      rental_listings.price_rental_daily_standard_season_currency,
      rental_listings.currency,
      rental_listings.import_url,
      rental_listings.created_at,
      rental_listings.updated_at,
      realty_assets.reference AS asset_reference,
      realty_assets.longitude,
      realty_assets.latitude,
      realty_assets.year_construction,
      realty_assets.count_bathrooms,
      realty_assets.count_bedrooms,
      realty_assets.count_toilets,
      realty_assets.count_garages,
      realty_assets.plot_area,
      realty_assets.constructed_area,
      realty_assets.area_unit,
      realty_assets.energy_rating,
      realty_assets.energy_performance,
      realty_assets.street_number,
      realty_assets.street_name,
      realty_assets.street_address,
      realty_assets.postal_code,
      realty_assets.province,
      realty_assets.city,
      realty_assets.city_search_key,
      realty_assets.region,
      realty_assets.country,
      realty_assets.floor,
      realty_assets.neighborhood,
      realty_assets.neighborhood_search_key,
      realty_assets.google_place_id
     FROM rental_listings,
      realty_assets
    WHERE (rental_listings.realty_asset_id = realty_assets.id);
  SQL
end
