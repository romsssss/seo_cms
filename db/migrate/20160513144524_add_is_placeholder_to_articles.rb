class AddIsPlaceholderToArticles < ActiveRecord::Migration
  def change
    add_column :seo_cms_articles, :is_placeholder, :boolean, null: false, default: false
  end
end
