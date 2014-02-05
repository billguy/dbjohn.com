class BlogsController < ApplicationController

  load_and_authorize_resource find_by: :permalink
  skip_load_resource only: [:create, :show]
  skip_authorize_resource only: [:index, :show]

  # GET /blogs
  # GET /blogs.json
  def index
    if params[:tag]
      @blogs = Blog.tagged_with(params[:tag], :match_all => true)
      @blogs = @blogs.filter_by( filter=params[:filter], published=!current_user.present?).page params[:page]
    else
      @blogs = Blog.filter_by( filter=params[:filter], published=!current_user.present?).page params[:page]
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.find_by!(permalink: params[:id])
    @previous_blog = @blog.prev(!current_user)
    @next_blog = @blog.next(!current_user)
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render action: 'show', status: :created, location: @blog }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:published, :title, :permalink, :content, :tag_list)
    end
end
