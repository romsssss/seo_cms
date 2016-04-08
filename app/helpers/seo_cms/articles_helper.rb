module SeoCms
  module ArticlesHelper
    def generate_breadcrumbs(breadcrumbs_info)
      breadcrumbs_info.map { |breadcrumb| link_to breadcrumb[:label], breadcrumb[:url] }.join(' > ').html_safe
    end
  end
end
