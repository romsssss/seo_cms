# Inspired by:  http://codeconnoisseur.org/ramblings/creating-dynamic-routes-at-runtime-in-rails-4
module SeoCms
  # Class used to dynamically generate routes from articles
  class DynamicRouter
    class << self
      def load
        return unless defined?(SeoCms::Article)
        return unless ActiveRecord::Base.connection.table_exists? 'seo_cms_articles'

        SeoCms::Engine.routes.draw do
          SeoCms::Article.all.each do |article|
            puts "routing #{article.url}"
            get article.url(false), to: 'articles#show', defaults: { id: article.id }
          end
        end
      end

      def reload
        # SeoCms::Engine.routes_reloader.reload!
      end
    end
  end
end
