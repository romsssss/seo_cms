require 'test_helper'

module SeoCms
  class ArticleTest < ActiveSupport::TestCase

    setup do
      @ninja_turtles = seo_cms_articles(:ninja_turtles)
      @michaelangelo = seo_cms_articles(:michaelangelo)
      @michaelangelo.parent = @ninja_turtles
    end

    test "should not save without uri" do
      article = Article.new
      assert(!article.valid?)
    end

    test "should have an unique uri" do
      article1 = Article.create(uri: 'my_uri')
      assert(article1.valid?)
      article2 = Article.new(uri: 'my_uri')
      assert(!article2.valid?)
    end

    test "has ancestry" do
      assert_respond_to(@ninja_turtles, :parent)
    end

    # url
    test "url returns the right url (without mounted path)" do
      assert_equal(@michaelangelo.url(false), '/ninja-turtles/michaelangelo')
    end
    test "url returns the right url (with mounted path)" do
      assert_equal(@michaelangelo.url, '/seo_cms/ninja-turtles/michaelangelo')
    end

    # breadcrumb_info
    test "breadcrumb_info returns a Hash" do
      assert_kind_of(Hash, @ninja_turtles.breadcrumb_info)
    end
    test "breadcrumb_info returns label and url information" do
      breadcrumb_info = @ninja_turtles.breadcrumb_info
      assert_equal(breadcrumb_info[:label], 'Ninja Turtles')
      assert_equal(breadcrumb_info[:url], '/seo_cms/ninja-turtles')
    end

    # breadcrumbs_info
    test "breadcrumbs_info returns an array" do
      assert_kind_of(Array, @ninja_turtles.breadcrumbs_info)
    end
    test "breadcrumbs_info returns its parents info" do
      assert_equal(@michaelangelo.breadcrumbs_info.size, 2)
    end

    # find_by_url
    test 'find_by_url returns nil when no article exists' do
      assert_nil(Article.find_by_url('/not/existing'))
    end
    test 'returns the right article' do
      result = Article.find_by_url('/ninja-turtles')
      assert_kind_of(Article, result)
      assert_equal(result, @ninja_turtles)
    end

  end
end
