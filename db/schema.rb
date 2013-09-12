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

ActiveRecord::Schema.define(:version => 20131207050927) do

  create_table "comments", :force => true do |t|
    t.date     "comment_created_at"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "track_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "comments", ["track_id"], :name => "index_comments_on_track_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "commentvectors", :force => true do |t|
    t.integer  "attempt"
    t.integer  "user_id"
    t.string   "word"
    t.float    "tf_idf"
    t.string   "prior_tfidf"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "commentvectors", ["attempt"], :name => "index_commentvectors_on_attempt"
  add_index "commentvectors", ["status"], :name => "index_commentvectors_on_status"
  add_index "commentvectors", ["user_id"], :name => "index_commentvectors_on_user_id"
  add_index "commentvectors", ["word"], :name => "index_commentvectors_on_word"

  create_table "corpus", :force => true do |t|
    t.integer  "attempt"
    t.string   "word"
    t.integer  "total_count"
    t.integer  "document_count"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "corpus", ["attempt"], :name => "index_corpus_on_attempt"
  add_index "corpus", ["document_count"], :name => "index_corpus_on_document_count"
  add_index "corpus", ["word"], :name => "index_corpus_on_word"

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "track_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorites", ["track_id"], :name => "index_favorites_on_track_id"
  add_index "favorites", ["user_id", "track_id"], :name => "index_favorites_on_user_id_and_track_id", :unique => true
  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "favoritevectors", :force => true do |t|
    t.integer  "attempt"
    t.integer  "user_id"
    t.string   "word"
    t.float    "tf_idf"
    t.string   "prior_tfidf"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "favoritevectors", ["attempt"], :name => "index_favoritevectors_on_attempt"
  add_index "favoritevectors", ["status"], :name => "index_favoritevectors_on_status"
  add_index "favoritevectors", ["user_id"], :name => "index_favoritevectors_on_user_id"
  add_index "favoritevectors", ["word"], :name => "index_favoritevectors_on_word"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "testavectors", :force => true do |t|
    t.integer  "attempt"
    t.integer  "user_id"
    t.string   "word"
    t.float    "tf_idf"
    t.string   "prior_tfidf"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "testavectors", ["attempt"], :name => "index_testavectors_on_attempt"
  add_index "testavectors", ["status"], :name => "index_testavectors_on_status"
  add_index "testavectors", ["user_id"], :name => "index_testavectors_on_user_id"
  add_index "testavectors", ["word"], :name => "index_testavectors_on_word"

  create_table "testbvectors", :force => true do |t|
    t.integer  "attempt"
    t.integer  "user_id"
    t.string   "word"
    t.float    "tf_idf"
    t.string   "prior_tfidf"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "testbvectors", ["attempt"], :name => "index_testbvectors_on_attempt"
  add_index "testbvectors", ["status"], :name => "index_testbvectors_on_status"
  add_index "testbvectors", ["user_id"], :name => "index_testbvectors_on_user_id"
  add_index "testbvectors", ["word"], :name => "index_testbvectors_on_word"

  create_table "tmp", :force => true do |t|
    t.integer  "attempt"
    t.integer  "user_id"
    t.string   "word"
    t.float    "tf_idf"
    t.string   "prior_tfidf"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tmp", ["attempt"], :name => "index_uservectors_on_attempt"
  add_index "tmp", ["status"], :name => "index_uservectors_on_status"
  add_index "tmp", ["user_id", "word"], :name => "user_id", :unique => true
  add_index "tmp", ["user_id"], :name => "index_uservectors_on_user_id"
  add_index "tmp", ["word"], :name => "index_uservectors_on_word"

  create_table "tracks", :force => true do |t|
    t.date     "track_created_at"
    t.integer  "user_id"
    t.text     "title"
    t.string   "sharing"
    t.text     "description"
    t.integer  "duration"
    t.string   "genre"
    t.integer  "shared_to_count"
    t.text     "tag_list"
    t.integer  "label_id"
    t.string   "label_name"
    t.string   "release"
    t.integer  "release_day"
    t.integer  "release_month"
    t.integer  "release_year"
    t.string   "license"
    t.string   "track_type"
    t.integer  "bpm"
    t.string   "key_signature"
    t.integer  "comment_count"
    t.integer  "download_count"
    t.integer  "playback_count"
    t.integer  "favoritings_count"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "tracks", ["genre"], :name => "index_tracks_on_genre"
  add_index "tracks", ["user_id"], :name => "index_tracks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "country"
    t.text     "full_name"
    t.string   "city"
    t.text     "description"
    t.integer  "track_count"
    t.integer  "playlist_count"
    t.integer  "followers_count"
    t.integer  "followings_count"
    t.integer  "public_favorites_count"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "uservectors", :force => true do |t|
    t.integer  "attempt"
    t.integer  "user_id"
    t.string   "word"
    t.float    "tf_idf"
    t.string   "prior_tfidf"
    t.string   "status"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "uservectors", ["attempt"], :name => "index_uservectors_on_attempt"
  add_index "uservectors", ["status"], :name => "index_uservectors_on_status"
  add_index "uservectors", ["user_id"], :name => "index_uservectors_on_user_id"
  add_index "uservectors", ["word"], :name => "index_uservectors_on_word"

  create_table "vectors", :force => true do |t|
    t.integer  "attempt"
    t.integer  "track_id"
    t.string   "word"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "idf"
    t.float    "tf_idf"
    t.string   "status"
  end

  add_index "vectors", ["attempt"], :name => "index_vectors_on_attempt"
  add_index "vectors", ["track_id"], :name => "index_vectors_on_track_id"
  add_index "vectors", ["word"], :name => "index_vectors_on_word"

  create_table "visiteds", :primary_key => "user_id", :force => true do |t|
    t.string   "status",             :default => "pending"
    t.text     "message"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "lock_version",       :default => 0
    t.integer  "priority",           :default => 0
    t.integer  "track_count"
    t.integer  "followed_processed", :default => 0
  end

  add_index "visiteds", ["status"], :name => "index_visiteds_on_status"

  create_table "word_clusters", :primary_key => "wmid", :force => true do |t|
    t.text    "word",    :null => false
    t.integer "cluster", :null => false
  end

end
