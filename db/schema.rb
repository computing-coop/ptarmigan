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

ActiveRecord::Schema.define(version: 20160119104735) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "airforms", force: :cascade do |t|
    t.text     "project_summary",         limit: 65535
    t.text     "detailed_description",    limit: 65535
    t.text     "events",                  limit: 65535
    t.text     "equipment",               limit: 65535
    t.integer  "applicant_id",            limit: 4,                     null: false
    t.text     "budget",                  limit: 65535
    t.boolean  "jul_aug"
    t.boolean  "sept_oct"
    t.boolean  "nov_dec"
    t.boolean  "submitted",                             default: false, null: false
    t.string   "cv_file_name",            limit: 255
    t.integer  "cv_file_size",            limit: 4
    t.string   "cv_content_type",         limit: 255
    t.datetime "cv_updated_at"
    t.string   "attachment_file_name",    limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.string   "attachment_content_type", limit: 255
    t.datetime "attachment_updated_at"
    t.boolean  "terms_agreed",                          default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applicants", force: :cascade do |t|
    t.string   "login",                     limit: 40
    t.string   "realname",                  limit: 100,   default: ""
    t.string   "country_of_residence",      limit: 100,                null: false
    t.string   "nationality",               limit: 100,                null: false
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           limit: 40
    t.datetime "activated_at"
    t.text     "address",                   limit: 65535,              null: false
    t.string   "phone",                     limit: 255,                null: false
  end

  add_index "applicants", ["login"], name: "index_applicants_on_login", unique: true, using: :btree

  create_table "artist_translations", force: :cascade do |t|
    t.integer  "artist_id",  limit: 4
    t.string   "locale",     limit: 255
    t.text     "bio",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artist_translations", ["artist_id"], name: "index_artist_translations_on_artist_id", using: :btree

  create_table "artists", force: :cascade do |t|
    t.date     "startdate"
    t.date     "enddate"
    t.string   "name",                  limit: 255
    t.string   "country",               limit: 255
    t.string   "website1",              limit: 255
    t.string   "website2",              limit: 255
    t.text     "bio_fi",                limit: 65535
    t.text     "bio",                   limit: 65535
    t.string   "avatar_file_name",      limit: 255
    t.string   "avatar_content_type",   limit: 255
    t.integer  "avatar_file_size",      limit: 4
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",           limit: 4,     default: 1, null: false
    t.string   "carousel_file_name",    limit: 255
    t.integer  "carousel_file_size",    limit: 4
    t.string   "carousel_content_type", limit: 255
    t.datetime "carousel_updated_at"
    t.string   "slug",                  limit: 255
    t.boolean  "include_in_carousel"
  end

  create_table "attendees", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "email",                   limit: 255
    t.string   "phone",                   limit: 255
    t.string   "pay_received",            limit: 255
    t.integer  "event_id",                limit: 4
    t.text     "comments",                limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "optional",                limit: 65535
    t.boolean  "showed_up"
    t.boolean  "waiting_list",                          default: false
    t.string   "profile_file_name",       limit: 255
    t.integer  "profile_file_size",       limit: 4
    t.string   "profile_content_type",    limit: 255
    t.datetime "profile_updated_at"
    t.text     "bio",                     limit: 65535
    t.string   "filmstill_file_name",     limit: 255
    t.integer  "filmstill_file_size",     limit: 4
    t.string   "filmstill_content_type",  limit: 255
    t.datetime "filmstill_updated_at"
    t.string   "comes_from",              limit: 255
    t.string   "work_in_progress_title",  limit: 255
    t.boolean  "approved"
    t.string   "project_or_organisation", limit: 255
    t.boolean  "invited"
  end

  create_table "budgetareas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cashes", force: :cascade do |t|
    t.string   "source",      limit: 255
    t.string   "title",       limit: 255
    t.string   "link_url",    limit: 255
    t.text     "content",     limit: 65535
    t.integer  "order",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id", limit: 4,     default: 1, null: false
    t.integer  "issued_at",   limit: 8
    t.string   "sourceid",    limit: 255
  end

  create_table "chatters", force: :cascade do |t|
    t.string   "subject",            limit: 255
    t.integer  "user_id",            limit: 4
    t.text     "body",               limit: 65535
    t.string   "image_file_name",    limit: 255
    t.integer  "image_file_size",    limit: 4
    t.string   "image_content_type", limit: 255
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "menuize"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255,             null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 25
    t.string   "guid",              limit: 10
    t.integer  "locale",            limit: 1,   default: 0
    t.integer  "user_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "fk_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_assetable_type", using: :btree
  add_index "ckeditor_assets", ["user_id"], name: "fk_user", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "chatter_id",         limit: 4
    t.text     "body",               limit: 65535
    t.string   "image_file_name",    limit: 255
    t.integer  "image_file_size",    limit: 4
    t.string   "image_content_type", limit: 255
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documenttypes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "event_translations", force: :cascade do |t|
    t.integer  "event_id",    limit: 4
    t.string   "locale",      limit: 255
    t.text     "description", limit: 65535
    t.text     "notes",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",       limit: 255
  end

  add_index "event_translations", ["event_id"], name: "index_event_translations_on_event_id", using: :btree

  create_table "eventcategories", force: :cascade do |t|
    t.string   "colour",     limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "eventcategories_events", id: false, force: :cascade do |t|
    t.integer "event_id",         limit: 4, null: false
    t.integer "eventcategory_id", limit: 4, null: false
  end

  add_index "eventcategories_events", ["event_id", "eventcategory_id"], name: "index_eventcategories_events_on_event_id_and_eventcategory_id", unique: true, using: :btree

  create_table "eventcategory_translations", force: :cascade do |t|
    t.integer  "eventcategory_id", limit: 4
    t.string   "locale",           limit: 255
    t.string   "name",             limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "eventcategory_translations", ["eventcategory_id"], name: "index_eventcategory_translations_on_eventcategory_id", using: :btree
  add_index "eventcategory_translations", ["locale"], name: "index_eventcategory_translations_on_locale", using: :btree

  create_table "events", force: :cascade do |t|
    t.datetime "date"
    t.string   "oldtitle",                limit: 255
    t.string   "promoter",                limit: 255
    t.string   "event_type",              limit: 255
    t.text     "description_fi",          limit: 65535
    t.text     "description",             limit: 65535
    t.float    "cost",                    limit: 24
    t.text     "metadata_fi",             limit: 65535
    t.text     "notes",                   limit: 65535
    t.string   "avatar_file_name",        limit: 255
    t.string   "avatar_content_type",     limit: 255
    t.integer  "avatar_file_size",        limit: 4
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id",               limit: 4
    t.boolean  "public"
    t.datetime "enddate"
    t.float    "discountedcost",          limit: 24
    t.integer  "project_id",              limit: 4
    t.string   "discountreason",          limit: 255
    t.integer  "facebook",                limit: 8
    t.integer  "publicschool",            limit: 4
    t.boolean  "registration_required",                 default: false, null: false
    t.integer  "registration_limit",      limit: 4
    t.integer  "location_id",             limit: 4,     default: 1,     null: false
    t.integer  "place_id",                limit: 4,     default: 1,     null: false
    t.string   "registration_recipient",  limit: 255
    t.string   "registration_optional_q", limit: 255
    t.boolean  "featured",                              default: false, null: false
    t.boolean  "hide_from_front",                       default: false, null: false
    t.string   "carousel_file_name",      limit: 255
    t.integer  "carousel_file_size",      limit: 4
    t.string   "carousel_content_type",   limit: 255
    t.datetime "carousel_updated_at"
    t.boolean  "donations_requested",                   default: false, null: false
    t.boolean  "hide_registrants",                      default: false, null: false
    t.string   "slug",                    limit: 255
    t.integer  "subsite_id",              limit: 4
    t.boolean  "show_on_main"
    t.boolean  "show_guests_to_public",                 default: false, null: false
    t.boolean  "require_approval",                      default: false, null: false
    t.string   "redirect_url",            limit: 255
    t.string   "otherweb",                limit: 255
    t.string   "event_time",              limit: 5
    t.string   "ticket_url",              limit: 255
    t.string   "avatar_dimensions",       limit: 255
    t.string   "carousel_dimensions",     limit: 255
  end

  create_table "expenses", force: :cascade do |t|
    t.date     "when"
    t.string   "recipient",     limit: 255
    t.string   "what_for",      limit: 255
    t.integer  "event_id",      limit: 4
    t.float    "amount",        limit: 24
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paid_by",       limit: 255
    t.integer  "budgetarea_id", limit: 4
    t.boolean  "has_receipt"
    t.integer  "location_id",   limit: 4
  end

  create_table "flickers", force: :cascade do |t|
    t.integer  "event_id",            limit: 4,     null: false
    t.string   "creator",             limit: 255
    t.integer  "hostid",              limit: 8
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",     limit: 255
    t.integer  "image_file_size",     limit: 4
    t.datetime "image_updated_at"
    t.string   "image_content_type",  limit: 255
    t.boolean  "is_video"
    t.boolean  "include_in_carousel"
    t.string   "image_dimensions",    limit: 255
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "incomes", force: :cascade do |t|
    t.date     "when"
    t.string   "recipient",     limit: 255
    t.string   "what_for",      limit: 255
    t.integer  "event_id",      limit: 4
    t.float    "amount",        limit: 24
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source",        limit: 255
    t.integer  "budgetarea_id", limit: 4
    t.boolean  "has_receipt"
    t.integer  "location_id",   limit: 4
  end

  create_table "instance_translations", force: :cascade do |t|
    t.integer  "instance_id",         limit: 4,     null: false
    t.string   "locale",              limit: 255,   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "special_information", limit: 65535
    t.text     "notes",               limit: 65535
  end

  add_index "instance_translations", ["instance_id"], name: "index_instance_translations_on_instance_id", using: :btree
  add_index "instance_translations", ["locale"], name: "index_instance_translations_on_locale", using: :btree

  create_table "instances", force: :cascade do |t|
    t.integer  "event_id",                  limit: 4
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "specialimage_file_name",    limit: 255
    t.integer  "specialimage_file_size",    limit: 4
    t.string   "specialimage_content_type", limit: 255
    t.datetime "specialimage_updated_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "ticket_url",                limit: 255
    t.string   "title",                     limit: 255
    t.float    "price",                     limit: 24
    t.float    "discounted_price",          limit: 24
    t.integer  "place_id",                  limit: 4
    t.string   "slug",                      limit: 255
  end

  add_index "instances", ["event_id"], name: "index_instances_on_event_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "international_name", limit: 255
    t.string   "locale",             limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations_places", id: false, force: :cascade do |t|
    t.integer "location_id", limit: 4, null: false
    t.integer "place_id",    limit: 4, null: false
  end

  create_table "locations_users", id: false, force: :cascade do |t|
    t.integer "location_id", limit: 4, null: false
    t.integer "user_id",     limit: 4, null: false
  end

  create_table "old_users", force: :cascade do |t|
    t.string   "login",                     limit: 40
    t.string   "name",                      limit: 100, default: ""
    t.string   "email",                     limit: 100
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
  end

  add_index "old_users", ["login"], name: "index_users_on_login", unique: true, using: :btree

  create_table "page_translations", force: :cascade do |t|
    t.integer  "page_id",    limit: 4
    t.string   "locale",     limit: 255
    t.text     "body",       limit: 65535
    t.string   "title",      limit: 255
    t.text     "excerpt",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_translations", ["page_id"], name: "index_page_translations_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.string   "title_fi",              limit: 255
    t.text     "body",                  limit: 65535
    t.text     "body_fi",               limit: 65535
    t.string   "slug",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "excerpt",               limit: 65535
    t.text     "abstract_fi",           limit: 65535
    t.integer  "location_id",           limit: 4,     default: 1, null: false
    t.integer  "subsite_id",            limit: 4
    t.string   "carousel_file_name",    limit: 255
    t.integer  "carousel_file_size",    limit: 4
    t.string   "carousel_content_type", limit: 255
    t.datetime "carousel_updated_at"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "address1",               limit: 255
    t.string   "address2",               limit: 255
    t.string   "city",                   limit: 255
    t.string   "country",                limit: 255
    t.string   "postcode",               limit: 255
    t.string   "map_url",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude",               limit: 53
    t.float    "longitude",              limit: 53
    t.boolean  "approved_for_posters"
    t.boolean  "allow_ptarmigan_events"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string   "number",              limit: 255
    t.string   "name",                limit: 255
    t.integer  "event_id",            limit: 4
    t.string   "cloudfront_filename", limit: 255
    t.boolean  "published"
    t.text     "description",         limit: 65535
    t.string   "slug",                limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "file_length",         limit: 4
  end

  add_index "podcasts", ["event_id"], name: "index_podcasts_on_event_id", using: :btree

  create_table "post_translations", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.string   "locale",     limit: 255
    t.text     "body",       limit: 65535
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_translations", ["post_id"], name: "index_post_translations_on_post_id", using: :btree

  create_table "postcategories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postcategories_posts", id: false, force: :cascade do |t|
    t.integer "post_id",         limit: 4, null: false
    t.integer "postcategory_id", limit: 4, null: false
  end

  create_table "postcategory_translations", force: :cascade do |t|
    t.integer  "postcategory_id", limit: 4,   null: false
    t.string   "locale",          limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",            limit: 255
  end

  add_index "postcategory_translations", ["locale"], name: "index_postcategory_translations_on_locale", using: :btree
  add_index "postcategory_translations", ["postcategory_id"], name: "index_postcategory_translations_on_postcategory_id", using: :btree

  create_table "postervotes", force: :cascade do |t|
    t.integer  "place_id",      limit: 4
    t.integer  "vote",          limit: 4
    t.string   "ip_address",    limit: 255
    t.string   "contact_email", limit: 255
    t.text     "comment",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "postervotes", ["place_id"], name: "index_postervotes_on_place_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",                   limit: 4,                   null: false
    t.integer  "location_id",               limit: 4,                   null: false
    t.boolean  "published",                             default: false, null: false
    t.boolean  "is_personal",                           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "carousel_file_name",        limit: 255
    t.integer  "carousel_file_size",        limit: 4
    t.string   "carousel_content_type",     limit: 255
    t.datetime "carousel_updated_at"
    t.boolean  "hide_carousel"
    t.string   "slug",                      limit: 255
    t.boolean  "not_news",                              default: false, null: false
    t.integer  "subsite_id",                limit: 4
    t.boolean  "show_on_main"
    t.integer  "embed_gallery_id",          limit: 4
    t.boolean  "embed_above_post",                      default: false, null: false
    t.integer  "second_embed_gallery_id",   limit: 4
    t.boolean  "sticky",                                default: false, null: false
    t.string   "alternateimg_file_name",    limit: 255
    t.integer  "alternateimg_file_size",    limit: 4
    t.string   "alternateimg_content_type", limit: 255
    t.datetime "alternateimg_updated_at"
    t.datetime "published_at"
    t.string   "carousel_dimensions",       limit: 255
    t.string   "alternateimg_dimensions",   limit: 255
  end

  create_table "presslinks", force: :cascade do |t|
    t.integer  "location_id",   limit: 4
    t.integer  "project_id",    limit: 4
    t.integer  "event_id",      limit: 4
    t.integer  "artist_id",     limit: 4
    t.boolean  "all_locations"
    t.string   "title",         limit: 255
    t.text     "description",   limit: 65535
    t.text     "url",           limit: 65535
    t.date     "when"
    t.float    "sortorder",     limit: 24
    t.string   "source",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_translations", force: :cascade do |t|
    t.integer  "project_id",  limit: 4
    t.string   "locale",      limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_translations", ["project_id"], name: "index_project_translations_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",                  limit: 255,                   null: false
    t.string   "website1",              limit: 255
    t.string   "website2",              limit: 255
    t.text     "description_fi",        limit: 65535
    t.text     "description",           limit: 65535
    t.string   "avatar_file_name",      limit: 255
    t.integer  "avatar_file_size",      limit: 4
    t.string   "avatar_content_type",   limit: 255
    t.datetime "avatar_updated_at"
    t.boolean  "active",                              default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",           limit: 4,     default: 1,     null: false
    t.boolean  "proposable",                          default: false, null: false
    t.boolean  "hidden",                              default: false, null: false
    t.string   "carousel_file_name",    limit: 255
    t.integer  "carousel_file_size",    limit: 4
    t.string   "carousel_content_type", limit: 255
    t.datetime "carousel_updated_at"
    t.string   "slug",                  limit: 255
    t.boolean  "include_in_carousel"
  end

  create_table "proposalcomments", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,     null: false
    t.integer  "proposal_id", limit: 4,     null: false
    t.text     "comment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", force: :cascade do |t|
    t.string   "location",                limit: 255
    t.string   "name",                    limit: 255
    t.string   "organisation",            limit: 255
    t.string   "email",                   limit: 255
    t.string   "address",                 limit: 255
    t.string   "country",                 limit: 255
    t.string   "phone_number",            limit: 255
    t.text     "short_description",       limit: 65535
    t.string   "duration",                limit: 255
    t.text     "long_description",        limit: 65535
    t.text     "public_engagement",       limit: 65535
    t.text     "materials",               limit: 65535
    t.text     "spatial_requirements",    limit: 65535
    t.text     "cost",                    limit: 65535
    t.text     "bio",                     limit: 65535
    t.text     "urls",                    limit: 65535
    t.text     "ptarmigan_goodfit",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id",              limit: 4
    t.string   "attachment_file_name",    limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.string   "attachment_content_type", limit: 255
    t.datetime "attachment_updated_at"
    t.boolean  "menuize"
    t.boolean  "archived"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.text     "description",             limit: 65535
    t.integer  "project_id",              limit: 4
    t.integer  "artist_id",               limit: 4
    t.integer  "event_id",                limit: 4
    t.string   "icon_file_name",          limit: 255
    t.integer  "icon_file_size",          limit: 4
    t.string   "icon_content_type",       limit: 255
    t.datetime "icon_updated_at"
    t.string   "attachment_file_name",    limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.string   "attachment_content_type", limit: 255
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "press_page"
    t.integer  "location_id",             limit: 4
    t.boolean  "all_locations"
    t.float    "sortorder",               limit: 24
    t.integer  "documenttype_id",         limit: 4
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "slugs", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "sluggable_id",   limit: 4
    t.integer  "sequence",       limit: 4,   default: 1, null: false
    t.string   "sluggable_type", limit: 40
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], name: "index_slugs_on_n_s_s_and_s", unique: true, using: :btree
  add_index "slugs", ["sluggable_id"], name: "index_slugs_on_sluggable_id", using: :btree

  create_table "subsites", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "fallback_theme",        limit: 255
    t.integer  "location_id",           limit: 4
    t.string   "carousel_file_name",    limit: 255
    t.string   "carousel_content_type", limit: 255
    t.date     "carousel_updated_at"
    t.integer  "carousel_file_size",    limit: 4
    t.string   "avatar_file_name",      limit: 255
    t.string   "avatar_content_type",   limit: 255
    t.date     "avatar_updated_at"
    t.integer  "avatar_file_size",      limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "hide_from_carousel"
    t.string   "human_name",            limit: 255
  end

  add_index "subsites", ["location_id"], name: "index_subsites_on_location_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "password_salt",          limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.string   "remember_token",         limit: 255
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "icon_file_name",         limit: 255
    t.integer  "icon_file_size",         limit: 4
    t.string   "icon_content_type",      limit: 255
    t.datetime "icon_updated_at"
    t.integer  "userlevel",              limit: 4,   default: 1,  null: false
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "videohosts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "videohost_id", limit: 4,     null: false
    t.integer  "event_id",     limit: 4,     null: false
    t.string   "creator",      limit: 255
    t.integer  "hostid",       limit: 8
    t.string   "name",         limit: 255,   null: false
    t.text     "description",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wikifiles", force: :cascade do |t|
    t.integer  "wikiattachment_id",       limit: 4
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",             limit: 65535
    t.string   "wikiattachment_type",     limit: 255
    t.integer  "documenttype_id",         limit: 4
  end

  create_table "wikipages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "menuize"
  end

  create_table "wikirevisions", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.text     "contents",    limit: 65535
    t.integer  "wikipage_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wikirevisions", ["wikipage_id"], name: "index_wikirevisions_on_wikipage_id", using: :btree

  create_table "will_filter_filters", force: :cascade do |t|
    t.string   "type",             limit: 255
    t.string   "name",             limit: 255
    t.text     "data",             limit: 65535
    t.integer  "user_id",          limit: 4
    t.string   "model_class_name", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "will_filter_filters", ["user_id"], name: "index_will_filter_filters_on_user_id", using: :btree

end
