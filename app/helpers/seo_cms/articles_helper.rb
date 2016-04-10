module SeoCms
  module ArticlesHelper
    def generate_breadcrumbs(breadcrumbs_info)
      breadcrumbs_info.each_with_index.map do |breadcrumb, i|
        last_element = (i == breadcrumbs_info.size - 1)
        if last_element
          breadcrumb[:label]
        else
          link_to(breadcrumb[:label], breadcrumb[:url])
        end
      end.join(' > ').html_safe
    end
  end
end
