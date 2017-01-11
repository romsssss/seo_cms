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

    def orphan_startegy_description
      case SeoCms.orphan_strategy
      when :destroy
        'all children will be destroyed'
      when :rootify
        'children node will become root nodes'
      when :restrict
        'cannot delete node if any children exist'
      when :adopt
        'orphan subtree will be added to the parent of the deleted node. If the deleted node is Root, then it will rootify the orphan subtree'
      end
    end
  end
end
