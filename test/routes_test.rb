require 'test_helper'

class RoutesTest < ActionController::TestCase

  setup do
    article_attributes = seo_cms_articles(:michaelangelo).attributes.reject { |k| %w(id ancestry created_at updated_at cached_url).include?(k) }
    article_attributes['uri'] = article_attributes['uri'] + Time.now.to_i.to_s
    @article = SeoCms::Article.create(article_attributes)
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

  test "should not show article (articles routes are auto generated)" do
    assert_raises(ActionController::RoutingError) do
      assert_recognizes({}, "/seo_cms/articles/#{@article.id}")
    end
  end

end
