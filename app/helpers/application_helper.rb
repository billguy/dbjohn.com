module ApplicationHelper

  def title(text)
    content_for(:title) { text }
  end

  def flash_class(level)
    case level
      when :notice then "alert alert-info alert-dismissable fade in"
      when :success then "alert alert-success alert-dismissable fade in"
      when :error then "alert alert-danger alert-dismissable fade in"
      when :alert then "alert alert-warning alert-dismissable fade in"
    end
  end

  def caption(pic)
    date = pic.date_taken || pic.updated_at
    pic_date = "#{date.strftime("%m.%d.%y %l:%M%p")}<br/>"
    location = pic.location
    model = pic.camera_model
    taken_with = model ? "<br/><span class='smaller'>Taken with a #{pic.camera_model}</span>" : nil
    near = location ? "<br/><span class='smaller'>#{location}</span>" : nil
    raw "#{pic_date}#{pic.title}#{taken_with}#{near}"
  end

  def filter_text
    filter = []
    if params[:tag]
      filter << link_to("tagged with '#{params[:tag]}'", url_for(only_path: true, filter: params[:filter]))
    end
    if params[:filter]
      filter << link_to("filtered by '#{params[:filter]}'", url_for(only_path: true, filter: params[:tag]))
    end
    "<div id='alert' class='alert alert-warning fade'>Viewing #{filter.join(" and ")}</div>".html_safe if filter.any?
  end

  def print_tags(model, tags)
    return '' if tags.size == 0
    output = "<ul class=\"inline tags\">"
    tags.each do |tag|
      output << "<li><a href=\"#{polymorphic_path(model, tag: tag.name, filter: params[:filter])}\">#{tag.name} <span>#{model.tagged_with(tag).length}</span></a></li>"
    end
    output << "</ul>"
    output.html_safe
  end
end
