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

ActiveRecord::Schema.define(version: 20171111123444) do

  create_table "activities", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "trackable_id"
    t.string "trackable_type"
    t.integer "owner_id"
    t.string "owner_type"
    t.string "key"
    t.text "parameters"
    t.integer "recipient_id"
    t.string "recipient_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "airforms", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.text "project_summary"
    t.text "detailed_description"
    t.text "events"
    t.text "equipment"
    t.integer "applicant_id", null: false
    t.text "budget"
    t.boolean "jul_aug"
    t.boolean "sept_oct"
    t.boolean "nov_dec"
    t.boolean "submitted", default: false, null: false
    t.string "cv_file_name"
    t.integer "cv_file_size"
    t.string "cv_content_type"
    t.datetime "cv_updated_at"
    t.string "attachment_file_name"
    t.integer "attachment_file_size"
    t.string "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.boolean "terms_agreed", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applicants", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "login", limit: 40
    t.string "realname", limit: 100, default: ""
    t.string "country_of_residence", limit: 100, null: false
    t.string "nationality", limit: 100, null: false
    t.string "crypted_password", limit: 40
    t.string "salt", limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "remember_token", limit: 40
    t.datetime "remember_token_expires_at"
    t.string "activation_code", limit: 40
    t.datetime "activated_at"
    t.text "address", null: false
    t.string "phone", null: false
    t.index ["login"], name: "index_applicants_on_login", unique: true
  end

  create_table "article_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "article_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "link_url"
    t.index ["article_id"], name: "index_article_translations_on_article_id"
    t.index ["locale"], name: "index_article_translations_on_locale"
  end

  create_table "articles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_articles_on_location_id"
  end

  create_table "artist_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "artist_id"
    t.string "locale"
    t.text "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["artist_id"], name: "index_artist_translations_on_artist_id"
  end

  create_table "artists", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.date "startdate"
    t.date "enddate"
    t.string "name"
    t.string "country"
    t.string "website1"
    t.string "website2"
    t.text "bio_fi"
    t.text "bio"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "location_id", default: 1, null: false
    t.string "carousel_file_name"
    t.integer "carousel_file_size"
    t.string "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.string "slug"
    t.boolean "include_in_carousel"
  end

  create_table "attendees", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "pay_received"
    t.integer "event_id"
    t.text "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "optional"
    t.boolean "showed_up"
    t.boolean "waiting_list", default: false
    t.string "profile_file_name"
    t.integer "profile_file_size"
    t.string "profile_content_type"
    t.datetime "profile_updated_at"
    t.text "bio"
    t.string "filmstill_file_name"
    t.integer "filmstill_file_size"
    t.string "filmstill_content_type"
    t.datetime "filmstill_updated_at"
    t.string "comes_from"
    t.string "work_in_progress_title"
    t.boolean "approved"
    t.string "project_or_organisation"
    t.boolean "invited"
  end

  create_table "budgetareas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calendarbackgrounds", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "image_file_name"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "image_content_type"
    t.string "image_dimensions"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carouselvideo_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "carouselvideo_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "subtitle"
    t.index ["carouselvideo_id"], name: "index_carouselvideo_translations_on_carouselvideo_id"
    t.index ["locale"], name: "index_carouselvideo_translations_on_locale"
  end

  create_table "carouselvideos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "location_id"
    t.integer "subsite_id"
    t.boolean "published"
    t.string "video_url"
    t.integer "video_height"
    t.integer "video_width"
    t.string "stillimage_file_name"
    t.integer "stillimage_file_size"
    t.string "stillimage_content_type"
    t.datetime "stillimage_updated_at"
    t.string "link_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cashes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string "source"
    t.text "title"
    t.string "link_url"
    t.text "content"
    t.integer "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "location_id", default: 1, null: false
    t.bigint "issued_at"
    t.string "sourceid"
    t.string "image_file_name"
    t.integer "image_file_size"
    t.string "image_content_type"
    t.datetime "image_updated_at"
    t.string "image_dimensions"
  end

  create_table "chatters", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "subject"
    t.integer "user_id"
    t.text "body"
    t.string "image_file_name"
    t.integer "image_file_size"
    t.string "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "menuize"
  end

  create_table "ckeditor_assets", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 25
    t.string "guid", limit: 10
    t.integer "locale", limit: 1, default: 0
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "fk_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_assetable_type"
    t.index ["user_id"], name: "fk_user"
  end

  create_table "comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "chatter_id"
    t.text "body"
    t.string "image_file_name"
    t.integer "image_file_size"
    t.string "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ctads", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "active"
    t.text "notes"
    t.string "wide_file_name"
    t.integer "wide_file_size"
    t.string "wide_content_type"
    t.datetime "wide_updated_at"
    t.string "boxy_file_name"
    t.integer "boxy_file_size"
    t.string "boxy_content_type"
    t.datetime "boxy_updated_at"
    t.string "boxy_dimensions"
    t.string "wide_dimensions"
    t.string "name"
    t.string "link_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documenttypes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id"
    t.string "locale"
    t.text "description"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title"
    t.index ["event_id"], name: "index_event_translations_on_event_id"
  end

  create_table "eventcategories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "colour"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eventcategories_events", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id", null: false
    t.integer "eventcategory_id", null: false
    t.index ["event_id", "eventcategory_id"], name: "index_eventcategories_events_on_event_id_and_eventcategory_id", unique: true
  end

  create_table "eventcategory_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "eventcategory_id"
    t.string "locale"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eventcategory_id"], name: "index_eventcategory_translations_on_eventcategory_id"
    t.index ["locale"], name: "index_eventcategory_translations_on_locale"
  end

  create_table "events", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "date"
    t.string "oldtitle"
    t.string "promoter"
    t.string "event_type"
    t.text "description_fi"
    t.string "cost"
    t.text "metadata_fi"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "artist_id"
    t.boolean "public"
    t.datetime "enddate"
    t.float "discountedcost", limit: 24
    t.integer "project_id"
    t.string "discountreason"
    t.bigint "facebook"
    t.integer "publicschool"
    t.boolean "registration_required", default: false, null: false
    t.integer "registration_limit"
    t.integer "location_id", default: 1, null: false
    t.integer "place_id", default: 1, null: false
    t.string "registration_recipient"
    t.string "registration_optional_q"
    t.boolean "featured", default: false, null: false
    t.boolean "hide_from_front", default: false, null: false
    t.string "carousel_file_name"
    t.integer "carousel_file_size"
    t.string "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.boolean "donations_requested", default: false, null: false
    t.boolean "hide_registrants", default: false, null: false
    t.string "slug"
    t.integer "subsite_id"
    t.boolean "show_on_main"
    t.boolean "show_guests_to_public", default: false, null: false
    t.boolean "require_approval", default: false, null: false
    t.string "redirect_url"
    t.string "otherweb"
    t.string "event_time", limit: 5
    t.string "ticket_url"
    t.string "avatar_dimensions"
    t.string "carousel_dimensions"
    t.boolean "secondary", default: false, null: false
    t.boolean "is_festival"
    t.string "teaser"
    t.string "article_link"
    t.string "video_link"
    t.index ["location_id"], name: "location_events_index"
  end

  create_table "expenses", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.date "when"
    t.string "recipient"
    t.string "what_for"
    t.integer "event_id"
    t.float "amount", limit: 24
    t.boolean "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "paid_by"
    t.integer "budgetarea_id"
    t.boolean "has_receipt"
    t.integer "location_id"
  end

  create_table "flickers", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id", null: false
    t.string "creator"
    t.bigint "hostid"
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "image_content_type"
    t.boolean "is_video"
    t.boolean "include_in_carousel"
    t.string "image_dimensions"
  end

  create_table "friendly_id_slugs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 40
    t.datetime "created_at"
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "incomes", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.date "when"
    t.string "recipient"
    t.string "what_for"
    t.integer "event_id"
    t.float "amount", limit: 24
    t.boolean "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "source"
    t.integer "budgetarea_id"
    t.boolean "has_receipt"
    t.integer "location_id"
  end

  create_table "instance_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "instance_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "special_information"
    t.text "notes"
    t.index ["instance_id"], name: "index_instance_translations_on_instance_id"
    t.index ["locale"], name: "index_instance_translations_on_locale"
  end

  create_table "instances", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "specialimage_file_name"
    t.integer "specialimage_file_size"
    t.string "specialimage_content_type"
    t.datetime "specialimage_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ticket_url"
    t.string "title"
    t.float "price", limit: 24
    t.float "discounted_price", limit: 24
    t.integer "place_id"
    t.string "slug"
    t.index ["event_id"], name: "index_instances_on_event_id"
  end

  create_table "locations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "international_name"
    t.string "locale", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations_places", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "location_id", null: false
    t.integer "place_id", null: false
  end

  create_table "locations_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "location_id", null: false
    t.integer "user_id", null: false
  end

  create_table "old_users", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "login", limit: 40
    t.string "name", limit: 100, default: ""
    t.string "email", limit: 100
    t.string "crypted_password", limit: 40
    t.string "salt", limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "remember_token", limit: 40
    t.datetime "remember_token_expires_at"
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "page_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "page_id"
    t.string "locale"
    t.text "body"
    t.string "title"
    t.text "excerpt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page_id"], name: "index_page_translations_on_page_id"
  end

  create_table "pages", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "title_fi"
    t.text "body"
    t.text "body_fi"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "excerpt"
    t.text "abstract_fi"
    t.integer "location_id", default: 1, null: false
    t.integer "subsite_id"
    t.string "carousel_file_name"
    t.integer "carousel_file_size"
    t.string "carousel_content_type"
    t.datetime "carousel_updated_at"
  end

  create_table "place_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "place_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_place_translations_on_locale"
    t.index ["place_id"], name: "index_place_translations_on_place_id"
  end

  create_table "places", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "country"
    t.string "postcode"
    t.string "map_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "latitude", limit: 53
    t.float "longitude", limit: 53
    t.boolean "approved_for_posters"
    t.boolean "allow_ptarmigan_events"
    t.boolean "creative_quarters", default: false, null: false
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "parent_id"
  end

  create_table "podcasts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "number"
    t.string "name"
    t.integer "event_id"
    t.string "cloudfront_filename"
    t.boolean "published"
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "file_length"
    t.index ["event_id"], name: "index_podcasts_on_event_id"
  end

  create_table "post_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "post_id"
    t.string "locale"
    t.text "body"
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id"], name: "index_post_translations_on_post_id"
  end

  create_table "postcategories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postcategories_posts", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "post_id", null: false
    t.integer "postcategory_id", null: false
  end

  create_table "postcategory_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "postcategory_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_postcategory_translations_on_locale"
    t.index ["postcategory_id"], name: "index_postcategory_translations_on_postcategory_id"
  end

  create_table "postervotes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "place_id"
    t.integer "vote"
    t.string "ip_address"
    t.string "contact_email"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_postervotes_on_place_id"
  end

  create_table "posts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "location_id", null: false
    t.boolean "published", default: false, null: false
    t.boolean "is_personal", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "carousel_file_name"
    t.integer "carousel_file_size"
    t.string "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.boolean "hide_carousel"
    t.string "slug"
    t.boolean "not_news", default: false, null: false
    t.integer "subsite_id"
    t.boolean "show_on_main"
    t.integer "embed_gallery_id"
    t.boolean "embed_above_post", default: false, null: false
    t.integer "second_embed_gallery_id"
    t.boolean "sticky", default: false, null: false
    t.string "alternateimg_file_name"
    t.integer "alternateimg_file_size"
    t.string "alternateimg_content_type"
    t.datetime "alternateimg_updated_at"
    t.datetime "published_at"
    t.string "carousel_dimensions"
    t.string "alternateimg_dimensions"
    t.index ["location_id"], name: "location_posts_index"
  end

  create_table "presslinks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "location_id"
    t.integer "project_id"
    t.integer "event_id"
    t.integer "artist_id"
    t.boolean "all_locations"
    t.string "title"
    t.text "description"
    t.text "url"
    t.date "when"
    t.float "sortorder", limit: 24
    t.string "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id"
    t.string "locale"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_id"], name: "index_project_translations_on_project_id"
  end

  create_table "projects", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "website1"
    t.string "website2"
    t.text "description_fi"
    t.text "description"
    t.string "avatar_file_name"
    t.integer "avatar_file_size"
    t.string "avatar_content_type"
    t.datetime "avatar_updated_at"
    t.boolean "active", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "location_id", default: 1, null: false
    t.boolean "proposable", default: false, null: false
    t.boolean "hidden", default: false, null: false
    t.string "carousel_file_name"
    t.integer "carousel_file_size"
    t.string "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.string "slug"
    t.boolean "include_in_carousel"
  end

  create_table "proposalcomments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "proposal_id", null: false
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "location"
    t.string "name"
    t.string "organisation"
    t.string "email"
    t.string "address"
    t.string "country"
    t.string "phone_number"
    t.text "short_description"
    t.string "duration"
    t.text "long_description"
    t.text "public_engagement"
    t.text "materials"
    t.text "spatial_requirements"
    t.text "cost"
    t.text "bio"
    t.text "urls"
    t.text "ptarmigan_goodfit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "project_id"
    t.string "attachment_file_name"
    t.integer "attachment_file_size"
    t.string "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.boolean "menuize"
    t.boolean "archived"
  end

  create_table "radiolink_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "radiolink_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_radiolink_translations_on_locale"
    t.index ["radiolink_id"], name: "index_radiolink_translations_on_radiolink_id"
  end

  create_table "radiolinks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "link_url"
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_radiolinks_on_location_id"
  end

  create_table "resources", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.integer "project_id"
    t.integer "artist_id"
    t.integer "event_id"
    t.string "icon_file_name"
    t.integer "icon_file_size"
    t.string "icon_content_type"
    t.datetime "icon_updated_at"
    t.string "attachment_file_name"
    t.integer "attachment_file_size"
    t.string "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "press_page"
    t.integer "location_id"
    t.boolean "all_locations"
    t.float "sortorder", limit: 24
    t.integer "documenttype_id"
  end

  create_table "roles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "slugs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "sluggable_id"
    t.integer "sequence", default: 1, null: false
    t.string "sluggable_type", limit: 40
    t.string "scope"
    t.datetime "created_at"
    t.index ["name", "sluggable_type", "sequence", "scope"], name: "index_slugs_on_n_s_s_and_s", unique: true
    t.index ["sluggable_id"], name: "index_slugs_on_sluggable_id"
  end

  create_table "subsites", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "fallback_theme"
    t.integer "location_id"
    t.string "carousel_file_name"
    t.string "carousel_content_type"
    t.date "carousel_updated_at"
    t.integer "carousel_file_size"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.date "avatar_updated_at"
    t.integer "avatar_file_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hide_from_carousel"
    t.string "human_name"
    t.index ["location_id"], name: "index_subsites_on_location_id"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "password_salt", default: "", null: false
    t.string "reset_password_token"
    t.string "remember_token"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "icon_file_name"
    t.integer "icon_file_size"
    t.string "icon_content_type"
    t.datetime "icon_updated_at"
    t.integer "userlevel", default: 1, null: false
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "videohosts", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "videohost_id", null: false
    t.integer "event_id", null: false
    t.string "creator"
    t.bigint "hostid"
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wikifiles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "wikiattachment_id"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.string "wikiattachment_type"
    t.integer "documenttype_id"
  end

  create_table "wikipages", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "menuize"
  end

  create_table "wikirevisions", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.text "contents"
    t.integer "wikipage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["wikipage_id"], name: "index_wikirevisions_on_wikipage_id"
  end

  create_table "will_filter_filters", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.string "name"
    t.text "data"
    t.integer "user_id"
    t.string "model_class_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_will_filter_filters_on_user_id"
  end

end
