require 'basics'
include BASICS

class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    #--------------------------
    # Steps
    # 1. Get genre id from params
    # 1-2. Get sort_type from params
    # 2. Get articles
    #--------------------------

    #--------------------------
    # 1. Get genre id
    #--------------------------    
    # @genre_id = params[:genre_id]
    if params[:genre]
        @genre_id = params[:genre][:id]
    else
        @genre_id = nil
    end
    
    if @genre_id != nil and BASICS.is_numeric?(@genre_id)
        genre_id = @genre_id.to_i
    else
        genre_id = nil
    end
    
    @params = params
    
    #--------------------------
    # 1-2. Get sort_type from params
    #--------------------------
    @sort_type = params[:sort_type]
    
    if @sort_type == nil
      @sort_type = "id"
    end
    
    #--------------------------
    # 2. Get articles
    #--------------------------
    @id_all = Genre.find_by_name("ALL")
    
    if @id_all.id.to_i == genre_id    #=> Select all items
      # @articles = Article.all
      @articles = Article.find(:all, :order => @sort_type)
    elsif genre_id          #=> Select by genre id
      # @articles = Article.find_all_by_genre_id(genre_id)
      # @articles = Article.find(:all, :genre_id => genre_id, :order => @sort_type)
      # @articles = Article.find_by_genre_id(:all, :order => @sort_type)
      @articles = Article.find_all_by_genre_id(genre_id, :order => @sort_type)
    else
      # @articles = Article.all
      @articles = Article.find(:all, :order => @sort_type)
    end#if @id_all.id.to_i == genre_id
  
    # session[:articles] = @articles    #=> ActionDispatch::Cookies::CookieOverflow in ArticlesController#index
            
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end#def index

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    @memos = Memo.find_all_by_article_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
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
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
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
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  def async_process
    
    @time = Time.now.to_s
    
    render :partial => 'async_current'
    # render text: "abcde"
    # render text: @time = Time.now.to_s
    # render text: Genre.all.first.name
    
    
    # @time = Time.now.to_s
#     
    # respond_to do |format|
      # # format.html { redirect_to articles_url }
      # format.js
      # format.json { head :no_content }
    # end
  end#def async_process

end
