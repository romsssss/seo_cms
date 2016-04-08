class Rails::Engine
  def self.mounted_path
    route = Rails.application.routes.routes.detect do |route|
      route.app == self
    end
    route && route.path
  end
end

module SeoCms
  class Article < ActiveRecord::Base
    attr_accessible :breadcrumb_title, :content, :is_placeholder, :metadata, :title, :uri, :parent_id

    has_ancestry orphan_strategy: :adopt

    validates :uri, uniqueness: true, presence: true
    validate :uniq_url, on: :create

    after_save :reload_routes

    def url(include_mount_endpoint = true)
      if include_mount_endpoint && SeoCms::Engine.mounted_path.spec.to_s != '/'
        SeoCms::Engine.mounted_path.spec.to_s + '/' + ancestors.map(&:uri).push(uri).join('/')
      else
        '/' + ancestors.map(&:uri).push(uri).join('/')
      end
    end

    def breadcrumbs_info
      ancestors.map(&:breadrcumb_info).push(breadrcumb_info)
    end

    def breadrcumb_info
      {
        label: breadcrumb_title,
        url: url
      }
    end

    private

    def uniq_url
      Rails.application.routes.recognize_path(url)
    rescue ActionController::RoutingError
    else
      errors.add(:uri, "#{url} url est déjà utilisée")
    end

    def reload_routes
      DynamicRouter.reload
    end
  end
end
