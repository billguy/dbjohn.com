class PicsController < ApplicationController

  load_and_authorize_resource find_by: :permalink
  skip_load_resource only: [:create]
  skip_authorize_resource only: [:index, :show, :approve]

  # GET /pics
  # GET /pics.json
  def index
    if params[:tags]
      @pics = Pic.tagged_with(params[:tags], :match_all => true)
      @pics = @pics.filter_by( filter: params[:filter], published: !current_user.present?).page params[:page]
    else
      @pics = Pic.filter_by( filter: params[:filter], published: !current_user.present?).page params[:page]
    end
  end

  # GET /pics/1
  # GET /pics/1.json
  def show
  end

  # GET /pics/new
  def new
    @pic = Pic.new
  end

  # GET /pics/1/edit
  def edit
  end

  def approve
    @pic.approve(params[:token])
  end

  # POST /pics
  # POST /pics.json
  def create
    @pic = Pic.new(pic_params)

    respond_to do |format|
      if @pic.save
        format.html { redirect_to @pic, notice: 'Pic was successfully created.' }
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
      params.require(:pic).permit(:published, :title, :attachment, :caption, :tag_list)
    end
end
