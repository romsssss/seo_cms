module SeoCms
  class Article < ActiveRecord::Base
    attr_accessible :breadcrumb_title, :content, :is_placeholder, :metadata, :title, :uri

    has_ancestry orphan_strategy: :adopt

    validates :uri, uniqueness: true, presence: true
    validate :uniq_url, on: :create

    after_save :reload_routes

    def url(include_mount_endpoint = true)
      mounted_on = SeoCms::Engine.mounted_path.spec.to_s
      path = '/' + ancestors.map(&:uri).push(uri).join('/')
      path = mounted_on + path if include_mount_endpoint &&  mounted_on != '/'
      path
    end

    def breadcrumbs_info
      ancestors.map(&:breadcrumb_info).push(breadcrumb_info)
    end

    def breadcrumb_info
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
