class SlogansController < ApplicationController

  load_and_authorize_resource
  skip_load_resource only: [:create]

  # GET /slogans
  # GET /slogans.json
  def index
    @slogans = Slogan.all
  end

  # GET /slogans/new
  def new
    @slogan = Slogan.new
  end

  # GET /slogans/1/edit
  def edit
  end

  # POST /slogans
  # POST /slogans.json
  def create
    @slogan = Slogan.new(slogan_params)

    respond_to do |format|
      if @slogan.save
        format.html { redirect_to slogans_path, notice: 'Slogan was successfully created.' }
        format.json { render action: 'show', status: :created, location: slogans_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @slogan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slogans/1
  # PATCH/PUT /slogans/1.json
  def update
    respond_to do |format|
      if @slogan.update(slogan_params)
        format.html { redirect_to slogans_path, notice: 'Slogan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @slogan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slogans/1
  # DELETE /slogans/1.json
  def destroy
    @slogan.destroy
    respond_to do |format|
      format.html { redirect_to slogans_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def slogan_params
      params.require(:slogan).permit(:active, :title)

    end
end
