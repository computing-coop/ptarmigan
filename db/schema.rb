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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140526181143) do

  create_table "activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["owner_id", "owner_type"], :name => "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], :name => "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], :name => "index_activities_on_trackable_id_and_trackable_type"

  create_table "airforms", :force => true do |t|
    t.text     "project_summary"
    t.text     "detailed_description"
    t.text     "events"
    t.text     "equipment"
    t.integer  "applicant_id",                               :null => false
    t.text     "budget"
    t.boolean  "jul_aug"
    t.boolean  "sept_oct"
    t.boolean  "nov_dec"
    t.boolean  "submitted",               :default => false, :null => false
    t.string   "cv_file_name"
    t.integer  "cv_file_size"
    t.string   "cv_content_type"
    t.datetime "cv_updated_at"
    t.string   "attachment_file_name"
    t.integer  "attachment_file_size"
    t.string   "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.boolean  "terms_agreed",            :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applicants", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "realname",                  :limit => 100, :default => ""
    t.string   "country_of_residence",      :limit => 100,                 :null => false
    t.string   "nationality",               :limit => 100,                 :null => false
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.text     "address",                                                  :null => false
    t.string   "phone",                                                    :null => false
  end

  add_index "applicants", ["login"], :name => "index_applicants_on_login", :unique => true

  create_table "artist_translations", :force => true do |t|
    t.integer  "artist_id"
    t.string   "locale"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artist_translations", ["artist_id"], :name => "index_artist_translations_on_artist_id"

  create_table "artists", :force => true do |t|
    t.date     "startdate"
    t.date     "enddate"
    t.string   "name"
    t.string   "country"
    t.string   "website1"
    t.string   "website2"
    t.text     "bio_fi"
    t.text     "bio"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",           :default => 1, :null => false
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.string   "slug"
    t.boolean  "include_in_carousel"
  end

  create_table "attendees", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "pay_received"
    t.integer  "event_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "optional"
    t.boolean  "showed_up"
    t.boolean  "waiting_list",           :default => false
    t.string   "profile_file_name"
    t.integer  "profile_file_size"
    t.string   "profile_content_type"
    t.datetime "profile_updated_at"
    t.text     "bio"
    t.string   "filmstill_file_name"
    t.integer  "filmstill_file_size"
    t.string   "filmstill_content_type"
    t.datetime "filmstill_updated_at"
    t.string   "comes_from"
    t.string   "work_in_progress_title"
    t.boolean  "approved"
  end

  create_table "budgetareas", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cashes", :force => true do |t|
    t.string   "source"
    t.string   "title"
    t.string   "link_url"
    t.text     "content"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chatters", :force => true do |t|
    t.string   "subject"
    t.integer  "user_id"
    t.text     "body"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "menuize"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                                 :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 25
    t.string   "guid",              :limit => 10
    t.integer  "locale",            :limit => 1,  :default => 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "fk_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_assetable_type"
  add_index "ckeditor_assets", ["user_id"], :name => "fk_user"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "chatter_id"
    t.text     "body"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documenttypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "event_translations", :force => true do |t|
    t.integer  "event_id"
    t.string   "locale"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "event_translations", ["event_id"], :name => "index_event_translations_on_event_id"

  create_table "events", :force => true do |t|
    t.date     "date"
    t.string   "oldtitle"
    t.string   "promoter"
    t.string   "event_type"
    t.text     "description_fi"
    t.text     "description"
    t.float    "cost"
    t.text     "metadata_fi"
    t.text     "notes"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
    t.boolean  "public"
    t.date     "enddate"
    t.float    "discountedcost"
    t.integer  "project_id"
    t.string   "discountreason"
    t.integer  "facebook",                :limit => 8
    t.integer  "publicschool"
    t.boolean  "registration_required",                :default => false, :null => false
    t.integer  "registration_limit"
    t.integer  "location_id",                          :default => 1,     :null => false
    t.integer  "place_id",                             :default => 1,     :null => false
    t.string   "registration_recipient"
    t.string   "registration_optional_q"
    t.boolean  "featured",                             :default => false, :null => false
    t.boolean  "hide_from_front",                      :default => false, :null => false
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.boolean  "donations_requested",                  :default => false, :null => false
    t.boolean  "hide_registrants",                     :default => false, :null => false
    t.string   "slug"
    t.integer  "subsite_id"
    t.boolean  "show_on_main"
    t.boolean  "show_guests_to_public",                :default => false, :null => false
    t.boolean  "require_approval",                     :default => false, :null => false
  end

  create_table "expenses", :force => true do |t|
    t.date     "when"
    t.string   "recipient"
    t.string   "what_for"
    t.integer  "event_id"
    t.float    "amount"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paid_by"
    t.integer  "budgetarea_id"
    t.boolean  "has_receipt"
    t.integer  "location_id"
  end

  create_table "flickers", :force => true do |t|
    t.integer  "event_id",                         :null => false
    t.string   "creator"
    t.integer  "hostid",              :limit => 8
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_content_type"
    t.boolean  "is_video"
    t.boolean  "include_in_carousel"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "incomes", :force => true do |t|
    t.date     "when"
    t.string   "recipient"
    t.string   "what_for"
    t.integer  "event_id"
    t.float    "amount"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.integer  "budgetarea_id"
    t.boolean  "has_receipt"
    t.integer  "location_id"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "international_name"
    t.string   "locale",             :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "old_users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "old_users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.text     "body"
    t.string   "title"
    t.text     "excerpt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "title_fi"
    t.text     "body"
    t.text     "body_fi"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "excerpt"
    t.text     "abstract_fi"
    t.integer  "location_id",           :default => 1, :null => false
    t.integer  "subsite_id"
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "country"
    t.string   "postcode"
    t.string   "map_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "approved_for_posters"
    t.boolean  "allow_ptarmigan_events"
  end

  create_table "podcasts", :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.integer  "event_id"
    t.string   "cloudfront_filename"
    t.boolean  "published"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "file_length"
  end

  add_index "podcasts", ["event_id"], :name => "index_podcasts_on_event_id"

  create_table "post_translations", :force => true do |t|
    t.integer  "post_id"
    t.string   "locale"
    t.text     "body"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_translations", ["post_id"], :name => "index_post_translations_on_post_id"

  create_table "postervotes", :force => true do |t|
    t.integer  "place_id"
    t.integer  "vote"
    t.string   "ip_address"
    t.string   "contact_email"
    t.text     "comment"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "postervotes", ["place_id"], :name => "index_postervotes_on_place_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id",                                      :null => false
    t.integer  "location_id",                                  :null => false
    t.boolean  "published",                 :default => false, :null => false
    t.boolean  "is_personal",               :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.boolean  "hide_carousel"
    t.string   "slug"
    t.boolean  "not_news",                  :default => false, :null => false
    t.integer  "subsite_id"
    t.boolean  "show_on_main"
    t.integer  "embed_gallery_id"
    t.boolean  "embed_above_post",          :default => false, :null => false
    t.integer  "second_embed_gallery_id"
    t.boolean  "sticky",                    :default => false, :null => false
    t.string   "alternateimg_file_name"
    t.integer  "alternateimg_file_size"
    t.string   "alternateimg_content_type"
    t.datetime "alternateimg_updated_at"
  end

  create_table "presslinks", :force => true do |t|
    t.integer  "location_id"
    t.integer  "project_id"
    t.integer  "event_id"
    t.integer  "artist_id"
    t.boolean  "all_locations"
    t.string   "title"
    t.text     "description"
    t.text     "url"
    t.date     "when"
    t.float    "sortorder"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_translations", :force => true do |t|
    t.integer  "project_id"
    t.string   "locale"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_translations", ["project_id"], :name => "index_project_translations_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name",                                     :null => false
    t.string   "website1"
    t.string   "website2"
    t.text     "description_fi"
    t.text     "description"
    t.string   "avatar_file_name"
    t.integer  "avatar_file_size"
    t.string   "avatar_content_type"
    t.datetime "avatar_updated_at"
    t.boolean  "active",                :default => true,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",           :default => 1,     :null => false
    t.boolean  "proposable",            :default => false, :null => false
    t.boolean  "hidden",                :default => false, :null => false
    t.string   "carousel_file_name"
    t.integer  "carousel_file_size"
    t.string   "carousel_content_type"
    t.datetime "carousel_updated_at"
    t.string   "slug"
    t.boolean  "include_in_carousel"
  end

  create_table "proposalcomments", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "proposal_id", :null => false
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", :force => true do |t|
    t.string   "location"
    t.string   "name"
    t.string   "organisation"
    t.string   "email"
    t.string   "address"
    t.string   "country"
    t.string   "phone_number"
    t.text     "short_description"
    t.string   "duration"
    t.text     "long_description"
    t.text     "public_engagement"
    t.text     "materials"
    t.text     "spatial_requirements"
    t.text     "cost"
    t.text     "bio"
    t.text     "urls"
    t.text     "ptarmigan_goodfit"
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

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.text     "description"
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
    t.float    "sortorder"
    t.integer  "documenttype_id"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "subsites", :force => true do |t|
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
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.boolean  "hide_from_carousel"
    t.string   "human_name"
  end

  add_index "subsites", ["location_id"], :name => "index_subsites_on_location_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "password_salt",                         :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
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
    t.integer  "userlevel",                             :default => 1,  :null => false
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videohosts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.integer  "videohost_id",              :null => false
    t.integer  "event_id",                  :null => false
    t.string   "creator"
    t.integer  "hostid",       :limit => 8
    t.string   "name",                      :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wikifiles", :force => true do |t|
    t.integer  "wikiattachment_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "wikiattachment_type"
    t.integer  "documenttype_id"
  end

  create_table "wikipages", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "menuize"
  end

  create_table "wikirevisions", :force => true do |t|
    t.integer  "user_id"
    t.text     "contents"
    t.integer  "wikipage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wikirevisions", ["wikipage_id"], :name => "index_wikirevisions_on_wikipage_id"

  create_table "will_filter_filters", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "data"
    t.integer  "user_id"
    t.string   "model_class_name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "will_filter_filters", ["user_id"], :name => "index_will_filter_filters_on_user_id"

end
