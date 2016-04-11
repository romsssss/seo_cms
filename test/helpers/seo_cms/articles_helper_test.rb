require 'test_helper'

module SeoCms
  class ArticlesHelperTest < ActionView::TestCase
    include ArticlesHelper

    setup do
      @michaelangelo = seo_cms_articles(:michaelangelo)
      @michaelangelo.parent = seo_cms_articles(:ninja_turtles)
    end


    test "breadcrumbs are properly generated" do
      breadcrumbs = generate_breadcrumbs(@michaelangelo.breadcrumbs_info)
      assert_equal(breadcrumbs, '<a href="/seo_cms/ninja-turtles">Ninja Turtles</a> > Michaelangelo')
    end

  end
end
