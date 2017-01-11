module SeoCms
  class Article < ActiveRecord::Base
    attr_accessible :breadcrumb_title, :content, :is_draft, :is_placeholder, :metadata, :title, :uri, :parent_id

    has_ancestry orphan_strategy: SeoCms.orphan_strategy

    validates :uri, presence: true
    validate :uri_format
    validate :cached_url, uniqueness: true
    validates_inclusion_of :is_draft, in: [true, false]
    validates_inclusion_of :is_placeholder, in: [true, false]
    validate :uniq_url

    before_save :cache_url
    after_save :reload_routes

    scope :published, -> { where(is_draft: false) }
    scope :drafted, -> { where(is_draft: true) }
    scope :routable, -> { published.where(is_placeholder: false) }

    class << self
      def mounted_path
        path = SeoCms::Engine.mounted_path.try(:spec).try(:to_s)
        path == '/' ? nil : path
      end

      def find_by_url(url)
        matched_urls = [url]
        matched_urls.unshift url.sub(/^#{mounted_path}/, '') if mounted_path
        where(cached_url: matched_urls).first
      end
    end

    def url(include_mount_endpoint = true)
      path = '/' + ancestors.map(&:uri).push(uri).join('/')
      path = Article.mounted_path + path if include_mount_endpoint && Article.mounted_path
      path
    end

    def breadcrumbs_info
      ancestors.map(&:breadcrumb_info).push(breadcrumb_info)
    end

    def breadcrumb_info
      {
        label: breadcrumb_title,
        is_draft: is_draft,
        url: url
      }
    end

    private

    def uniq_url
      return unless SeoCms.check_routes_uniqueness
      return if is_draft
      Rails.application.routes.recognize_path(url)
    rescue ActionController::RoutingError
    else
      errors.add(:uri, "#{url} url est déjà utilisée")
    end

    def uri_format
      URI(uri)
    rescue URI::InvalidURIError
      errors.add(:uri, "est invalide")
    rescue ArgumentError
      errors.add(:uri, "doit être une string")
    end

    def reload_routes
      return unless SeoCms.reload_routes_on_the_fly
      need_reload = uri_changed? || ancestry_changed? || is_draft_changed?
      DynamicRouter.reload if need_reload
    end

    def cache_url
      self.cached_url = url(false)
    end
  end
end
