require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do
    @article = seo_cms_articles(:michaelangelo)
    @routes = SeoCms::Engine.routes
  end

  test "browse articles" do
    get "/seo_cms/seo_content"
    assert_response :success
    assert assigns(:articles)
  end

  test "browse article" do
    get @article.url
    assert_response :success
    assert assigns(:article)
  end

  test "access new article page" do
    get "/seo_cms/seo_content/new"
    assert_response :success
    assert assigns(:article)
  end

  test "create new article" do
    post "/seo_cms/seo_content", article: {
      breadcrumb_title: @article.breadcrumb_title,
      content: @article.content,
      is_placeholder: @article.is_placeholder,
      metadata: @article.metadata,
      title: @article.title,
      uri: "#{@article.uri}#{Time.now.to_i}"
    }

    article = assigns(:article)
    assert_not_nil(article)
    assert(article.errors.count == 0)
    assert_equal("Nouvel article créé.", flash[:notice])
  end

  test "update article" do
    put "/seo_cms/seo_content/#{@article.id}", article: {
      title: 'new title'
    }

    article = assigns(:article)
    assert_not_nil(article)
    assert(article.errors.count == 0)
    assert_equal("Article modifié.", flash[:notice])
  end

  test "delete article" do
    delete "/seo_cms/seo_content/#{@article.id}"

    assert_equal("Article supprimé.", flash[:notice])
  end
end

