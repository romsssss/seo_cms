require 'test_helper'

module SeoCms
  class ArticlesControllerTest < ActionController::TestCase
    setup do
      @routes = SeoCms::Engine.routes
      @article = seo_cms_articles(:michaelangelo)
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
          is_placeholder: @article.is_placeholder,
          metadata: @article.metadata,
          title: @article.title,
          uri: "#{@article.uri}#{Time.now.to_i}"
        }
      end
      assert_not_nil assigns(:parents)
      assert_redirected_to articles_path
    end

    test "should not show article (articles routes are auto generated)" do
      assert_raise(ActionController::RoutingError) { get :show, id: @article }
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
        is_placeholder: @article.is_placeholder,
        metadata: @article.metadata,
        title: @article.title,
        uri: "#{@article.uri}#{Time.now.to_i}"
      }
      assert_not_nil assigns(:parents)
      assert_redirected_to articles_path
    end

    test "should destroy article" do
      assert_difference('Article.count', -1) do
        delete :destroy, id: @article
      end
      assert_redirected_to articles_path
    end
  end
end
