class AddCachedUrlToSeoCmsArticles < ActiveRecord::Migration
  def up
    add_column :seo_cms_articles, :cached_url, :string
    add_index :seo_cms_articles, :cached_url

    SeoCms::Article.reset_column_information
    SeoCms::Article.find_each(&:save)

    change_column :seo_cms_articles, :cached_url, :string, null: false
  end

  def down
    remove_column :seo_cms_articles, :cached_url
  end
end
