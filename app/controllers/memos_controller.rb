class MemosController < ApplicationController
  # GET /memos
  # GET /memos.json
  def index
    #--------------------------
    # Steps
    # 1. Get sort_type from params
    
    #--------------------------

    #--------------------------
    # 1. Get sort_type from params
    #--------------------------
    @sort_type = params[:sort_type]
    
    if @sort_type == nil
      @sort_type = "id"
    end

    
    # Get memos
    @memos = Memo.find(:all, :order => @sort_type)
    # @memos = Memo.find(:all, :order => "article_id")
    
    # @memos = @memos.sort {|a, b| a.article.genre_id <=> b.article.genre_id}
    # @memos = @memos.sort {|a, b| a.article.genre_id <=> b.article.genre_id}
    
    # @memos = Memo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memos }
    end
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
    @memo = Memo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @memo }
    end
  end

  # GET /memos/new
  # GET /memos/new.json
  def new
    @memo = Memo.new
    
    #
    @article_id = params[:article_id]
    
    if @article_id != nil
      @memo.article_id = @article_id
    end
    
    #-------------------
    # Log
    #-------------------
    @log_message = params[:controller] + "/" + params[:action]
    
    @log = Log.new
    @log.activity = @log_message
    
    if @log.save
      flash[:log_saved] = "Log saved"
      # On "flash" => "黒田・佐藤":124
    else
      flash[:log_saved] = "Log not saved!"
    end
    
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @memo }
    end
  end

  # GET /memos/1/edit
  def edit
    @memo = Memo.find(params[:id])
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(params[:memo])

    # Log --------------------------
    # @log = Log.new
    # @log.memos = params[:controller] + "/" + params[:action] +
                        # #" => " + @memo.id + " : " + @memo.title
                        # " => " + @memo.title
    
    # if @log.save
      # flash[:log_saved] = "Log saved"
      # flash[:log_saved] = @memo.text
      # flash[:log_saved] = "@memo.id => " + @memo.id.to_s
      # On "flash" => "黒田・佐藤":124
    # else
      # flash[:log_saved] = "Log not saved!"
    # end
    
    #/ Log --------------------------

    respond_to do |format|
      if @memo.save
        
        # Log --------------------------
        @log = Log.new
        @log.memos = params[:controller] + "/" + params[:action] +
                            # " => " + @memo.id + " : " + @memo.text
                            # " => " + @memo.title
                            " => " + @memo.id.to_s + " : " + @memo.text
        
        if @log.save
          flash[:log_saved] = "Log saved"
          # flash[:log_saved] = @memo.text
          # flash[:log_saved] = "@memo.id => " + @memo.id.to_s
          # On "flash" => "黒田・佐藤":124lse
        else
          flash[:log_saved] = "Log not saved!"
        end
        
        #/ Log --------------------------
        # Log
        # flash[:log_saved] = @memo.title
        # flash[:log_saved] = "@memo.id => " + @memo.id.to_s
        
        format.html { redirect_to @memo, notice: 'Memo was successfully created.' }
        format.json { render json: @memo, status: :created, location: @memo }
      else
        format.html { render action: "new" }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /memos/1
  # PUT /memos/1.json
  def update
    @memo = Memo.find(params[:id])

    respond_to do |format|
      if @memo.update_attributes(params[:memo])
        format.html { redirect_to @memo, notice: 'Memo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy

    respond_to do |format|
      format.html { redirect_to memos_url }
      format.json { head :no_content }
    end
  end
end
