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

ActiveRecord::Schema.define(:version => 20160607081846) do

  create_table "seo_cms_articles", :force => true do |t|
    t.string   "title"
    t.text     "metadata"
    t.text     "content"
    t.string   "breadcrumb_title"
    t.string   "uri"
    t.boolean  "is_draft",         :default => true
    t.string   "ancestry"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "cached_url",                         :null => false
    t.boolean  "is_placeholder",   :default => true, :null => false
  end

  add_index "seo_cms_articles", ["ancestry"], :name => "index_seo_cms_articles_on_ancestry"
  add_index "seo_cms_articles", ["cached_url"], :name => "index_seo_cms_articles_on_cached_url"

end
