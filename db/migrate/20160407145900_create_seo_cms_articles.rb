class CreateSeoCmsArticles < ActiveRecord::Migration
  def change
    create_table :seo_cms_articles do |t|
      t.string :title
      t.text :metadata
      t.text :content
      t.string :breadcrumb_title
      t.string :uri
      t.boolean :is_placeholder
      t.string :ancestry

      t.timestamps
    end
    add_index :seo_cms_articles, :ancestry
  end
end
