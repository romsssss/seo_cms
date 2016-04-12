module SeoCms
  module ApplicationHelper
    def bootstrap_class_for flash_type
      case flash_type
        when :success
          "alert-success"
        when :error
          "alert-error"
        when :alert
          "alert-block"
        when :notice
          "alert-info"
        else
          flash_type.to_s
      end
    end

    def generate_title(article)
      if SeoCms.title_suffix.nil?
        article.title
      else
        "#{article.title} | #{SeoCms.title_suffix}"
      end
    end
  end
end
