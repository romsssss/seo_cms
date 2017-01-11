require 'test_helper'

module SeoCms
  class ArticleTest < ActiveSupport::TestCase
    setup do
      @ninja_turtles = seo_cms_articles(:ninja_turtles)
      @michaelangelo = seo_cms_articles(:michaelangelo)
      @leonardo = seo_cms_articles(:leonardo)
      @michaelangelo.parent = @ninja_turtles
      @leonardo.parent = @ninja_turtles
    end

    #  uri
    test "should not save without uri" do
      article = Article.new
      assert(!article.valid?)
    end
    test "should have a valid uri" do
      article1 = Article.new(uri: 'invalid uri', is_draft: false)
      assert(!article1.valid?)
      article2 = Article.new(uri: 1, is_draft: false)
      assert(!article2.valid?)
    end

    test "has ancestry" do
      assert_respond_to(@ninja_turtles, :parent)
    end

    # scopes
    test "published scope returned expected articles" do
      @ninja_turtles.update_attribute(:is_draft, true)
      @michaelangelo.update_attribute(:is_draft, false)
      assert_equal(false, Article.published.include?(@ninja_turtles))
      assert_equal(true, Article.published.include?(@michaelangelo))
    end
    test "drafted scope returned expected articles" do
      @ninja_turtles.update_attribute(:is_draft, true)
      @michaelangelo.update_attribute(:is_draft, false)
      assert_equal(true, Article.drafted.include?(@ninja_turtles))
      assert_equal(false, Article.drafted.include?(@michaelangelo))
    end
    test "routable scope returned expected articles" do
      @ninja_turtles.update_attributes(is_draft: false, is_placeholder: false)
      @michaelangelo.update_attributes(is_draft: false, is_placeholder: true)
      @leonardo.update_attributes(is_draft: true, is_placeholder: true)
      assert_equal(true, Article.routable.include?(@ninja_turtles))
      assert_equal(false, Article.routable.include?(@michaelangelo))
      assert_equal(false, Article.routable.include?(@leonardo))
    end

    # url
    test "url returns the right url (without mounted path)" do
      assert_equal(@michaelangelo.url(false), '/ninja-turtles/michaelangelo')
    end
    test "url returns the right url (with mounted path)" do
      assert_equal(@michaelangelo.url, '/seo_cms/ninja-turtles/michaelangelo')
    end

    # cached_url
    test "cached_url stores the url (without mounted path)" do
      article = Article.create!(uri: 'rafaelo', is_draft: true, parent_id: @ninja_turtles.id)
      assert_equal(article.cached_url, '/ninja-turtles/rafaelo')
      article.update_attributes(uri: 'donatello')
      assert_equal(article.cached_url, '/ninja-turtles/donatello')
    end

    # breadcrumb_info
    test "breadcrumb_info returns a Hash" do
      assert_kind_of(Hash, @ninja_turtles.breadcrumb_info)
    end
    test "breadcrumb_info returns label, draft and url information" do
      breadcrumb_info = @ninja_turtles.breadcrumb_info
      assert_equal(breadcrumb_info[:label], 'Ninja Turtles')
      assert_equal(breadcrumb_info[:url], '/seo_cms/ninja-turtles')
      assert_equal(breadcrumb_info[:is_draft], false)
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
      @ninja_turtles.save
      result = Article.find_by_url('/ninja-turtles')
      assert_kind_of(Article, result)
      assert_equal(result, @ninja_turtles)
    end
  end
end
