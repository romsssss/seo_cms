# Inspired by:  http://codeconnoisseur.org/ramblings/creating-dynamic-routes-at-runtime-in-rails-4
module SeoCms
  # Class used to dynamically generate routes from articles
  class DynamicRouter
    class << self
      def load
        return unless ActiveRecord::Base.connection.table_exists? 'seo_cms_articles'

        SeoCms::Engine.routes.draw do
          resources :articles, path: 'seo_content', only: [:index, :new, :create, :edit, :update, :destroy] do
            collection do
              get 'url_availability'
            end
            member do
              get 'preview'
            end
          end
          SeoCms::Article.routable.each do |article|
            # puts "routing #{article.url}"
            get article.url(false), to: 'articles#show', defaults: { id: article.id }
          end
        end
      end
      alias_method :reload, :load
    end
  end
end
