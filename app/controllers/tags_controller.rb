class TagsController < ApplicationController

  respond_to :json

  def index
    if params[:q]
      tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{params[:q]}%")
      if tags.any?
        tags.collect!{|t| {id: t.name, name: t.name}}
      else
        tags = [ {id: params[:q], name: params[:q]} ]
      end
      respond_with tags
    else
      respond_with ActsAsTaggableOn::Tag.all
    end
  end
end
