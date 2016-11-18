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

ActiveRecord::Schema.define(version: 20161118135801) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "airforms", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.text     "project_summary",         limit: 65535
    t.text     "detailed_description",    limit: 65535
    t.text     "events",                  limit: 65535
    t.text     "equipment",               limit: 65535
    t.integer  "applicant_id",                                          null: false
    t.text     "budget",                  limit: 65535
    t.boolean  "jul_aug"
    t.boolean  "sept_oct"
    t.boolean  "nov_dec"
    t.boolean  "submitted",                             default: false, null: false
    t.string   "cv_file_name"
    t.integer  "cv_file_size"
    t.string   "cv_content_type"
    t.datetime "cv_updated_at"
    t.string   "attachment_file_name"
    t.integer  "attachment_file_size"
    t.string   "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.boolean  "terms_agreed",                          default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applicants", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
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
    t.string   "phone",                                                null: false
    t.index ["login"], name: "index_applicants_on_login", unique: true, using: :btree
  end

  create_table "artist_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "artist_id"
    t.string   "locale"
    t.text     "bio",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["artist_id"], name: "index_artist_translations_on_artist_id", using: :btree
  end

  create_table "artists", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.date     "startdate"
    t.date     "enddate"
    t.string   "name"
    t.string   "country"
    t.string   "website1"
    t.string   "website2"
    t.text     "bio_fi",                limit: 65535
    t.text     "bio",                   limit: 65535
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",                         default: 1, null: false
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.string   "slug"
    t.boolean  "include_in_carousel"
  end

  create_table "attendees", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "pay_received"
    t.integer  "event_id"
    t.text     "comments",                limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "optional",                limit: 65535
    t.boolean  "showed_up"
    t.boolean  "waiting_list",                          default: false
    t.string   "profile_file_name"
    t.integer  "profile_file_size"
    t.string   "profile_content_type"
    t.datetime "profile_updated_at"
    t.text     "bio",                     limit: 65535
    t.string   "filmstill_file_name"
    t.integer  "filmstill_file_size"
    t.string   "filmstill_content_type"
    t.datetime "filmstill_updated_at"
    t.string   "comes_from"
    t.string   "work_in_progress_title"
    t.boolean  "approved"
    t.string   "project_or_organisation"
    t.boolean  "invited"
  end

  create_table "budgetareas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calendarbackgrounds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_content_type"
    t.string   "image_dimensions"
    t.boolean  "active",             default: false, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "cashes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "source"
    t.text     "title",              limit: 65535
    t.string   "link_url"
    t.text     "content",            limit: 65535
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",                      default: 1, null: false
    t.bigint   "issued_at"
    t.string   "sourceid"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.string   "image_dimensions"
  end

  create_table "chatters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "subject"
    t.integer  "user_id"
    t.text     "body",               limit: 65535
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "menuize"
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",                           null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 25
    t.string   "guid",              limit: 10
    t.integer  "locale",            limit: 1,  default: 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "fk_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_assetable_type", using: :btree
    t.index ["user_id"], name: "fk_user", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "chatter_id"
    t.text     "body",               limit: 65535
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documenttypes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "event_id"
    t.string   "locale"
    t.text     "description", limit: 65535
    t.text     "notes",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.index ["event_id"], name: "index_event_translations_on_event_id", using: :btree
  end

  create_table "eventcategories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "colour"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eventcategories_events", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id",         null: false
    t.integer "eventcategory_id", null: false
    t.index ["event_id", "eventcategory_id"], name: "index_eventcategories_events_on_event_id_and_eventcategory_id", unique: true, using: :btree
  end

  create_table "eventcategory_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "eventcategory_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["eventcategory_id"], name: "index_eventcategory_translations_on_eventcategory_id", using: :btree
    t.index ["locale"], name: "index_eventcategory_translations_on_locale", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "date"
    t.string   "oldtitle"
    t.string   "promoter"
    t.string   "event_type"
    t.text     "description_fi",          limit: 65535
    t.float    "cost",                    limit: 24
    t.text     "metadata_fi",             limit: 65535
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
    t.boolean  "public"
    t.datetime "enddate"
    t.float    "discountedcost",          limit: 24
    t.integer  "project_id"
    t.string   "discountreason"
    t.bigint   "facebook"
    t.integer  "publicschool"
    t.boolean  "registration_required",                 default: false, null: false
    t.integer  "registration_limit"
    t.integer  "location_id",                           default: 1,     null: false
    t.integer  "place_id",                              default: 1,     null: false
    t.string   "registration_recipient"
    t.string   "registration_optional_q"
    t.boolean  "featured",                              default: false, null: false
    t.boolean  "hide_from_front",                       default: false, null: false
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.boolean  "donations_requested",                   default: false, null: false
    t.boolean  "hide_registrants",                      default: false, null: false
    t.string   "slug"
    t.integer  "subsite_id"
    t.boolean  "show_on_main"
    t.boolean  "show_guests_to_public",                 default: false, null: false
    t.boolean  "require_approval",                      default: false, null: false
    t.string   "redirect_url"
    t.string   "otherweb"
    t.string   "event_time",              limit: 5
    t.string   "ticket_url"
    t.string   "avatar_dimensions"
    t.string   "carousel_dimensions"
    t.boolean  "secondary",                             default: false, null: false
    t.boolean  "is_festival"
  end

  create_table "expenses", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.date     "when"
    t.string   "recipient"
    t.string   "what_for"
    t.integer  "event_id"
    t.float    "amount",        limit: 24
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paid_by"
    t.integer  "budgetarea_id"
    t.boolean  "has_receipt"
    t.integer  "location_id"
  end

  create_table "flickers", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer  "event_id",                          null: false
    t.string   "creator"
    t.bigint   "hostid"
    t.string   "name"
    t.text     "description",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_content_type"
    t.boolean  "is_video"
    t.boolean  "include_in_carousel"
    t.string   "image_dimensions"
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "incomes", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.date     "when"
    t.string   "recipient"
    t.string   "what_for"
    t.integer  "event_id"
    t.float    "amount",        limit: 24
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.integer  "budgetarea_id"
    t.boolean  "has_receipt"
    t.integer  "location_id"
  end

  create_table "instance_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "instance_id",                       null: false
    t.string   "locale",                            null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "special_information", limit: 65535
    t.text     "notes",               limit: 65535
    t.index ["instance_id"], name: "index_instance_translations_on_instance_id", using: :btree
    t.index ["locale"], name: "index_instance_translations_on_locale", using: :btree
  end

  create_table "instances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "event_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "specialimage_file_name"
    t.integer  "specialimage_file_size"
    t.string   "specialimage_content_type"
    t.datetime "specialimage_updated_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "ticket_url"
    t.string   "title"
    t.float    "price",                     limit: 24
    t.float    "discounted_price",          limit: 24
    t.integer  "place_id"
    t.string   "slug"
    t.index ["event_id"], name: "index_instances_on_event_id", using: :btree
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "international_name"
    t.string   "locale",             limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations_places", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "location_id", null: false
    t.integer "place_id",    null: false
  end

  create_table "locations_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "location_id", null: false
    t.integer "user_id",     null: false
  end

  create_table "old_users", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "login",                     limit: 40
    t.string   "name",                      limit: 100, default: ""
    t.string   "email",                     limit: 100
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
    t.index ["login"], name: "index_users_on_login", unique: true, using: :btree
  end

  create_table "page_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.text     "body",       limit: 65535
    t.string   "title"
    t.text     "excerpt",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page_id"], name: "index_page_translations_on_page_id", using: :btree
  end

  create_table "pages", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "title_fi"
    t.text     "body",                  limit: 65535
    t.text     "body_fi",               limit: 65535
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "excerpt",               limit: 65535
    t.text     "abstract_fi",           limit: 65535
    t.integer  "location_id",                         default: 1, null: false
    t.integer  "subsite_id"
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
  end

  create_table "place_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "place_id",   null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.index ["locale"], name: "index_place_translations_on_locale", using: :btree
    t.index ["place_id"], name: "index_place_translations_on_place_id", using: :btree
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "country"
    t.string   "postcode"
    t.string   "map_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude",               limit: 53
    t.float    "longitude",              limit: 53
    t.boolean  "approved_for_posters"
    t.boolean  "allow_ptarmigan_events"
    t.boolean  "creative_quarters",                 default: false, null: false
    t.integer  "lft",                                               null: false
    t.integer  "rgt",                                               null: false
    t.integer  "parent_id"
  end

  create_table "podcasts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "number"
    t.string   "name"
    t.integer  "event_id"
    t.string   "cloudfront_filename"
    t.boolean  "published"
    t.text     "description",         limit: 65535
    t.string   "slug"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "file_length"
    t.index ["event_id"], name: "index_podcasts_on_event_id", using: :btree
  end

  create_table "post_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "post_id"
    t.string   "locale"
    t.text     "body",       limit: 65535
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id"], name: "index_post_translations_on_post_id", using: :btree
  end

  create_table "postcategories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postcategories_posts", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "post_id",         null: false
    t.integer "postcategory_id", null: false
  end

  create_table "postcategory_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "postcategory_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.index ["locale"], name: "index_postcategory_translations_on_locale", using: :btree
    t.index ["postcategory_id"], name: "index_postcategory_translations_on_postcategory_id", using: :btree
  end

  create_table "postervotes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "place_id"
    t.integer  "vote"
    t.string   "ip_address"
    t.string   "contact_email"
    t.text     "comment",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["place_id"], name: "index_postervotes_on_place_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                   null: false
    t.integer  "location_id",                               null: false
    t.boolean  "published",                 default: false, null: false
    t.boolean  "is_personal",               default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.boolean  "hide_carousel"
    t.string   "slug"
    t.boolean  "not_news",                  default: false, null: false
    t.integer  "subsite_id"
    t.boolean  "show_on_main"
    t.integer  "embed_gallery_id"
    t.boolean  "embed_above_post",          default: false, null: false
    t.integer  "second_embed_gallery_id"
    t.boolean  "sticky",                    default: false, null: false
    t.string   "alternateimg_file_name"
    t.integer  "alternateimg_file_size"
    t.string   "alternateimg_content_type"
    t.datetime "alternateimg_updated_at"
    t.datetime "published_at"
    t.string   "carousel_dimensions"
    t.string   "alternateimg_dimensions"
  end

  create_table "presslinks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "location_id"
    t.integer  "project_id"
    t.integer  "event_id"
    t.integer  "artist_id"
    t.boolean  "all_locations"
    t.string   "title"
    t.text     "description",   limit: 65535
    t.text     "url",           limit: 65535
    t.date     "when"
    t.float    "sortorder",     limit: 24
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id"
    t.string   "locale"
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_id"], name: "index_project_translations_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                                null: false
    t.string   "website1"
    t.string   "website2"
    t.text     "description_fi",        limit: 65535
    t.text     "description",           limit: 65535
    t.string   "avatar_file_name"
    t.integer  "avatar_file_size"
    t.string   "avatar_content_type"
    t.datetime "avatar_updated_at"
    t.boolean  "active",                              default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",                         default: 1,     null: false
    t.boolean  "proposable",                          default: false, null: false
    t.boolean  "hidden",                              default: false, null: false
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.string   "slug"
    t.boolean  "include_in_carousel"
  end

  create_table "proposalcomments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                   null: false
    t.integer  "proposal_id",               null: false
    t.text     "comment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "location"
    t.string   "name"
    t.string   "organisation"
    t.string   "email"
    t.string   "address"
    t.string   "country"
    t.string   "phone_number"
    t.text     "short_description",       limit: 65535
    t.string   "duration"
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
    t.integer  "project_id"
    t.string   "attachment_file_name"
    t.integer  "attachment_file_size"
    t.string   "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.boolean  "menuize"
    t.boolean  "archived"
  end

  create_table "resources", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description",             limit: 65535
    t.integer  "project_id"
    t.integer  "artist_id"
    t.integer  "event_id"
    t.string   "icon_file_name"
    t.integer  "icon_file_size"
    t.string   "icon_content_type"
    t.datetime "icon_updated_at"
    t.string   "attachment_file_name"
    t.integer  "attachment_file_size"
    t.string   "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "press_page"
    t.integer  "location_id"
    t.boolean  "all_locations"
    t.float    "sortorder",               limit: 24
    t.integer  "documenttype_id"
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                  default: 1, null: false
    t.string   "sluggable_type", limit: 40
    t.string   "scope"
    t.datetime "created_at"
    t.index ["name", "sluggable_type", "sequence", "scope"], name: "index_slugs_on_n_s_s_and_s", unique: true, using: :btree
    t.index ["sluggable_id"], name: "index_slugs_on_sluggable_id", using: :btree
  end

  create_table "subsites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "fallback_theme"
    t.integer  "location_id"
    t.string   "carousel_file_name"
    t.string   "carousel_content_type"
    t.date     "carousel_updated_at"
    t.integer  "carousel_file_size"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.date     "avatar_updated_at"
    t.integer  "avatar_file_size"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "hide_from_carousel"
    t.string   "human_name"
    t.index ["location_id"], name: "index_subsites_on_location_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "password_salt",                      default: "", null: false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "icon_file_name"
    t.integer  "icon_file_size"
    t.string   "icon_content_type"
    t.datetime "icon_updated_at"
    t.integer  "userlevel",                          default: 1,  null: false
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "videohosts", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer  "videohost_id",               null: false
    t.integer  "event_id",                   null: false
    t.string   "creator"
    t.bigint   "hostid"
    t.string   "name",                       null: false
    t.text     "description",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wikifiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "wikiattachment_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",             limit: 65535
    t.string   "wikiattachment_type"
    t.integer  "documenttype_id"
  end

  create_table "wikipages", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "menuize"
  end

  create_table "wikirevisions", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "contents",    limit: 65535
    t.integer  "wikipage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["wikipage_id"], name: "index_wikirevisions_on_wikipage_id", using: :btree
  end

  create_table "will_filter_filters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "name"
    t.text     "data",             limit: 65535
    t.integer  "user_id"
    t.string   "model_class_name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["user_id"], name: "index_will_filter_filters_on_user_id", using: :btree
  end

end
