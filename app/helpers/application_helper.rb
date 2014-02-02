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
    pic_date = date.strftime("%m.%d.%y %l:%M%p")
    location = pic.location
    model = pic.camera_model
    taken_with = location && model ? "Taken with a #{pic.camera_model} near #{location}<br/>" : nil
    raw "#{pic_date}<br/>#{taken_with} #{pic.caption}"
  end

  def print_tags(model, tags)
    return '' if tags.size == 0
    output = "<ul class=\"inline tags\">"
    tags.each do |tag|
      output << "<li><a href=\"#{pics_path(tags: [tag.name])}\">#{tag.name} <span>#{model.tagged_with(tag).length}</span></a></li>"
    end
    output << "</ul>"
    output.html_safe

  end
end
