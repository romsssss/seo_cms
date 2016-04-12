require 'test_helper'

class RoutesTest < ActionController::TestCase

  setup do
    @article = seo_cms_articles(:michaelangelo)
    @routes = SeoCms::Engine.routes
  end

  test 'content management is reachable with /seo_content' do
    assert_routing(
      { method: 'get', path: '/seo_content' },
      { controller: 'seo_cms/articles', action: 'index' }
    )
  end

  test 'Articles routes are auto generated' do
    assert_routing(
      { method: 'get', path: @article.url(false) },
      { controller: 'seo_cms/articles', action: 'show', id: @article.id }
    )
  end

  # test "should not show article (articles routes are auto generated)" do
  #   assert_raise(ActionController::RoutingError) { get :show, id: @article }
  # end

end
