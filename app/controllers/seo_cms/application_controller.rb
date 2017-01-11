module SeoCms
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    def seo_cms_authorize
      defined?(self.can_access_seo_cms) ? can_access_seo_cms : true
    end
  end
end
