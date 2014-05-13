class TagsController < ApplicationController

  def index
    authorize! :index, ActsAsTaggableOn::Tag
    respond_to do |format|
      format.html {
        @tags = ActsAsTaggableOn::Tag.all
      }
      format.json{
        if params[:q]
          tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{params[:q]}%")
          if tags.any?
            tags.collect!{|t| {id: t.name, name: t.name}}
          else
            tags = [ {id: params[:q], name: params[:q]} ]
          end
          render json: tags
        else
          render json: ActsAsTaggableOn::Tag.all
        end
      }
    end
  end

  def edit
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    authorize! :edit, @tag
  end

  def update
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    authorize! :update, @tag
    if @tag.update(tag_params)
      redirect_to tags_path, notice: 'Tag was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def tag_params
    params.require(:acts_as_taggable_on_tag).permit(:name, :color)
  end

end
