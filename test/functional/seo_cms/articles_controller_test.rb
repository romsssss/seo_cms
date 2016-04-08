require 'test_helper'

module SeoCms
  class ArticlesControllerTest < ActionController::TestCase
    setup do
      @article = articles(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:articles)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create article" do
      assert_difference('Article.count') do
        post :create, article: { breadcrumb_title: @article.breadcrumb_title, content: @article.content, is_placeholder: @article.is_placeholder, metadata: @article.metadata, title: @article.title, uri: @article.uri }
      end
  
      assert_redirected_to article_path(assigns(:article))
    end
  
    test "should show article" do
      get :show, id: @article
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @article
      assert_response :success
    end
  
    test "should update article" do
      put :update, id: @article, article: { breadcrumb_title: @article.breadcrumb_title, content: @article.content, is_placeholder: @article.is_placeholder, metadata: @article.metadata, title: @article.title, uri: @article.uri }
      assert_redirected_to article_path(assigns(:article))
    end
  
    test "should destroy article" do
      assert_difference('Article.count', -1) do
        delete :destroy, id: @article
      end
  
      assert_redirected_to articles_path
    end
  end
end