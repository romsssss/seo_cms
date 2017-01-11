class ChangeDefaultForIsDraft < ActiveRecord::Migration
  def up
    change_column :seo_cms_articles, :is_draft, :boolean, default: true
  end

  def down
    change_column :seo_cms_articles, :is_draft, :boolean, default: nil
  end
end
