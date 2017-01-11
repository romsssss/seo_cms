require 'test_helper'

module SeoCms
  class ArticlesControllerTest < ActionController::TestCase
    setup do
      @routes = SeoCms::Engine.routes
      @article = seo_cms_articles(:michaelangelo)
    end

    def forbid_access
      # Add can_access_seo_cms method to ApplicationController on runtime
      ApplicationController.class_eval do
        def can_access_seo_cms
          render nothing: true, status: :forbidden
        end
      end
    end

    def grant_access_back
      # Remove can_access_seo_cms method to ApplicationController on runtime
      ApplicationController.class_eval { undef :can_access_seo_cms }
    end

    test "access can be restricted" do
      forbid_access
      get :index
      assert_response :forbidden
      assert_nil assigns(:articles)
      grant_access_back
    end

    test "index is reachable with /seo_content" do
      get :index
      assert_response :success
      assert_not_nil assigns(:articles)
    end

    test "should get new" do
      get :new
      assert_response :success
      assert_not_nil assigns(:article)
      assert_not_nil assigns(:parents)
    end

    test "should create article" do
      assert_difference('Article.count') do
        post :create, article: {
          breadcrumb_title: @article.breadcrumb_title,
          content: @article.content,
          is_draft: @article.is_draft,
          metadata: @article.metadata,
          title: @article.title,
          uri: "#{@article.uri}#{Time.now.to_i}"
        }
      end
      assert_not_nil assigns(:parents)
      assert_redirected_to [:edit, SeoCms::Article.last]
    end

    test "should get edit" do
      get :edit, id: @article
      assert_response :success
      assert_not_nil assigns(:article)
      assert_not_nil assigns(:parents)
    end

    test "should update article" do
      put :update, id: @article, article: {
        breadcrumb_title: @article.breadcrumb_title,
        content: @article.content,
        title: @article.title
      }
      assert_not_nil assigns(:parents)
      assert_redirected_to [:edit, @article]
    end

    test "should destroy article" do
      assert_difference('Article.count', -1) do
        delete :destroy, id: @article
      end
      assert_redirected_to articles_path
    end

    test "url_availability accepts valid urls" do
      get :url_availability, { url: '/this/is/a/valid/url' }, format: 'json'
      assert_response :success
      body = JSON.parse(response.body)
      assert_equal(true, body['available'])
      assert_equal('/this/is/a/valid/url', body['url'])
      assert_equal('', body['message'])
    end

    test "url_availability rejects invalid urls" do
      get :url_availability, { url: '/this/ is not /a/valid/url' }, format: 'json'
      assert_response :success
      body = JSON.parse(response.body)
      assert_equal(false, body['available'])
      assert_equal('/this/ is not /a/valid/url', body['url'])
      assert_equal('url invalide', body['message'])
    end

    # test "url_availability rejects already used urls" do
    #   Article.create!(uri: 'myurl', is_draft: false)
    #   get :url_availability, { url: '/seo_cms/myurl' }, format: 'json'
    #   assert_response :success
    #   body = JSON.parse(response.body)
    #   assert_equal(false, body['available'])
    #   assert_equal('/seo_cms/myurl', body['url'])
    #   assert_equal('url déjà utilisée', body['message'])
    # end

    test "url_availability must have an url params" do
      get :url_availability, format: 'json'
      assert_response :success
      body = JSON.parse(response.body)
      assert_equal(false, body['available'])
      assert_equal('', body['url'])
      assert_equal('url doit être une string', body['message'])
    end
  end
end
