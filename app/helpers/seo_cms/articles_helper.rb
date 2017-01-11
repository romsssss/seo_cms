module SeoCms
  module ArticlesHelper
    # Generate breadcrumbs with link from breadcrumbs_info
    # breadcrumbs_info = [{
    #   label: "Breadcrumb Title",
    #   is_draft: false,
    #   url: '/path/to/breadcrumb-title'
    # } ,{
    #   ...
    # }]
    def generate_breadcrumbs breadcrumbs_info, view_context=nil
      breadcrumbs_info.each_with_index.map do |breadcrumb, i|
        last_element = (i == breadcrumbs_info.size - 1)
        if last_element || breadcrumb[:is_draft]
          breadcrumb[:label]
        else
          if view_context.nil?
            link_to(breadcrumb[:label], breadcrumb[:url])
          else
            view_context.link_to(breadcrumb[:label], breadcrumb[:url])
          end
        end
      end.join(' > ').html_safe
    end

    def status_labels article
      labels = []
      labels.push(type: 'info', content: 'Placeholder') if article.is_placeholder
      labels.push(article.is_draft ? { type: 'warning', content: 'Brouillon' } : { type: 'success', content: 'Publié' })
      labels.map { |label| "<span class='label label-#{label[:type]}'>#{label[:content]}</span>" }.join(' ')
    end
  end
end
