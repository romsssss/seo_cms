class ChangePlaceholderDefault < ActiveRecord::Migration
  def up
    change_column :seo_cms_articles, :is_placeholder, :boolean, default: true
  end

  def down
    change_column :seo_cms_articles, :is_placeholder, :boolean, default: false
  end
end
