require_dependency "seo_cms/application_controller"

module SeoCms
  class ArticlesController < ApplicationController
    include ArticlesHelper # use of generate_breadcrumbs
    before_filter :retrieve_article, only: [:show, :preview, :edit, :update, :destroy]
    before_filter :retrieve_parents, only: [:new, :edit, :create, :update]
    before_filter :load_cms_options, only: [:new, :edit, :create, :update]
    before_filter :seo_cms_authorize, except: [:show]

    layout SeoCms.layout, only: [:show, :preview]

    # GET /articles
    # GET /articles.json
    def index
      @articles = Article.all.sort_by(&:url)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @articles }
      end
    end

    # GET /articles/1
    # GET /articles/1.json
    def show
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @article }
      end
    end

    # GET /articles/preview/1
    # GET /articles/preview/1.json
    def preview
      respond_to do |format|
        format.html { render 'show' }
        format.json { render json: @article }
      end
    end

    # GET /articles/new
    # GET /articles/new.json
    def new
      @article = Article.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @article }
      end
    end

    # GET /articles/1/edit
    def edit
      @parent_url = Hash[@parents.map {|k, v| [v, k]}][@article.parent_id]
    end

    # POST /articles
    # POST /articles.json
    def create
      @article = Article.new(params[:article])

      respond_to do |format|
        if @article.save
          format.html { redirect_to [:edit, @article], notice: 'Nouvel article créé.' }
          format.json { render json: @article, status: :created, location: @article }
        else
          format.html { render action: "new" }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /articles/1
    # PUT /articles/1.json
    def update
      respond_to do |format|
        if @article.update_attributes(params[:article])
          format.html { redirect_to [:edit, @article], notice: 'Article modifié.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /articles/1
    # DELETE /articles/1.json
    def destroy
      @article.destroy

      respond_to do |format|
        format.html { redirect_to articles_url, notice: 'Article supprimé.' }
        format.json { head :no_content }
      end
    end

    def url_availability
      url = URI(params[:url])
      message = ''
      Rails.application.routes.recognize_path(url)
    rescue URI::InvalidURIError
      available = false
      url = params[:url]
      message = 'url invalide'
    rescue ArgumentError
      available = false
      url = params[:url]
      message = 'url doit être une string'
    rescue ActionController::RoutingError
      available = true
    else
      available = false
      message = 'url déjà utilisée'
    ensure
      render json: { url: url.to_s, available: available, message: message }
    end

    private

    def retrieve_article
      @article = Article.find(params[:id])
    end

    # https://github.com/stefankroes/ancestry/wiki/Creating-a-selectbox-for-a-form-using-ancestry
    def retrieve_parents
      @parents_urls = {}
      @parents_breadcrumbs = {}
      @parents = Article.all.each do |a|
        @parents_urls[a.id] = a.url
        @parents_breadcrumbs[a.id] = generate_breadcrumbs(a.breadcrumbs_info, view_context)
        a.ancestry = a.ancestry.to_s + (!a.ancestry.nil? ? '/' : '') + a.id.to_s
      end
      @parents.sort! { |x, y| x.ancestry <=> y.ancestry }
      @parents.map! { |a| ['-' * (a.depth - 1) + a.breadcrumb_title, a.id] }
      @parents.unshift(['-- none --', nil])
    end

    def load_cms_options
      @layout = SeoCms.layout
      @orphan_strategy = SeoCms.orphan_strategy
      @title_suffix = SeoCms.title_suffix
      @reload_routes_on_the_fly = SeoCms.reload_routes_on_the_fly
      @check_routes_uniqueness = SeoCms.check_routes_uniqueness
    end
  end
end
