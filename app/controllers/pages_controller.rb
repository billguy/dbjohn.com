class PagesController < ApplicationController
  load_and_authorize_resource find_by: :permalink
  skip_load_resource only: [:create, :show, :index]
  skip_authorize_resource only: [:show, :index]

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find_by_permalink(params[:id]) or current_user ? redirect_to(action: :new, id: params[:id]) : redirect_to(root_url, flash: {alert: "Page not found"})
  end

  # GET /pages/new
  def new
    title = params[:id].titleize rescue nil
    permalink = params[:id].parameterize rescue nil
    @page = Page.new(title: title, permalink: permalink, content: 'click edit to change content')
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    respond_to do |format|
      if @page.save
        format.html { redirect_to page_path(@page), notice: 'Page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page }
      else
        flash[:notice] = @page.errors.full_messages.to_sentence
        format.html { render action: 'new' }
        format.json { render json: [@page.errors.full_messages.to_sentence], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to page_path(@page), notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        flash[:notice] = @page.errors.full_messages.to_sentence
        format.html { render action: 'edit' }
        format.json { render json: [@page.errors.full_messages.to_sentence], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:title, :permalink, :content, :javascript)
  end
end
