class PicsController < ApplicationController

  load_and_authorize_resource find_by: :permalink
  skip_load_resource only: [:create, :show]
  skip_authorize_resource only: [:index, :show, :approve]

  # GET /pics
  # GET /pics.json
  def index
    tags = params[:tags] ? params[:tags].reject(&:blank?) : []
    if tags.any?
      @pics = Pic.tagged_with(tags)
      @pics = @pics.filter_by( filter=params[:filter], published=!current_user.present?).page params[:page]
    else
      @pics = Pic.filter_by( filter=params[:filter], published=!current_user.present?).page params[:page]
    end

    respond_to do |format|
      format.html
      format.js {
        @geo_center = Geocoder::Calculations.geographic_center @pics.collect(&:to_coord).compact || Pic.default_coord
      }
    end
  end

  # GET /pics/1
  # GET /pics/1.json
  def show
    @pic = Pic.find_by!(permalink: params[:id])
    flash.now[:notice] = "This pic is not published" unless @pic.published
    @previous_pic = @pic.prev(!current_user) || @pic.last
    @next_pic = @pic.next(!current_user) || @pic.first
  end

  # GET /pics/new
  def new
    @pic = Pic.new
  end

  # GET /pics/1/edit
  def edit
  end

  def approve
    if @pic.approve(params[:token])
      redirect_to @pic
    else
      redirect_to root_path, notice: 'Incorrect token.'
    end
  end

  # POST /pics
  # POST /pics.json
  def create
    @pic = Pic.new(pic_params)

    respond_to do |format|
      if @pic.save
        if params[:add_another]
          format.html { redirect_to new_pic_path, notice: 'Pic was successfully created.' }
        else
          format.html { redirect_to @pic, notice: 'Pic was successfully created.' }
        end
        format.json { render action: 'show', status: :created, location: @pic }
      else
        format.html { render action: 'new' }
        format.json { render json: @pic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pics/1
  # PATCH/PUT /pics/1.json
  def update
    respond_to do |format|
      if @pic.update(pic_params)
        format.html { redirect_to @pic, notice: 'Pic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pics/1
  # DELETE /pics/1.json
  def destroy
    @pic.destroy
    respond_to do |format|
      format.html { redirect_to pics_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def pic_params
      params.require(:pic).permit(:published, :title, :attachment, :caption, :tag_list, :add_another)
    end
end
