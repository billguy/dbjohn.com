module ApplicationHelper
  def deparameterize(thing)
    thing.gsub(/%2F/, '/').gsub(/[_|-]/, ' ')
  end

  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-info alert-dismissable fade"
      when :success then "alert alert-success alert-dismissable fade"
      when :error then "alert alert-danger alert-dismissable fade"
      when :alert then "alert alert-warning alert-dismissable fade"
    end
  end

  def caption(pic)
    pic_date = pic.date_taken || pic.updated_at.strftime("%m.%d.%y %l:%M%p")
    location = pic.location
    details = pic.details
    camera = pic.camera_model ? "<br/><span class='smaller'>#{pic.camera_model}</span>" : nil
    taken_with = details ? "<br/><span class='smaller'>#{details}</span>" : nil
    near = location ? "<br/><span class='smaller'>#{location}</span>" : nil
    raw "#{pic_date}<br/>#{pic.title}#{camera}#{taken_with}#{near}"
  end

  def filter_text
    filter = []
    h_params = params.to_h
    new_params = h_params.except(:controller, :action)
    param_tags = h_params[:tags] ? h_params[:tags].reject(&:blank?) : []
    if param_tags.any?
      tags = param_tags.map{|tag| link_to(tag, url_for( new_params.merge( (new_tags = param_tags.reject{|t| t == tag}).empty? ? {} : { tags: new_tags} ).except(new_tags.empty? ? :tags : nil))) }
      filter << "tagged with " + tags.join(', ')
    end
    if h_params[:filter]
      filter << "filtered by " + link_to(h_params[:filter], url_for(new_params.except(:filter).merge(tags: h_params[:tags])))
    end
    "<div id='alert' class='alert alert-warning fade'>Viewing #{filter.join(" and ")}</div>".html_safe if filter.any?
  end

  def print_tags(model, tags)
    return '' if tags.size == 0
    output = "<ul class=\"list-inline tags\">"
    h_params = params.to_h
    param_tags = h_params[:tags] || []
    param_tags.reject!(&:blank?)
    tags.reject{|t| param_tags.include?(t.name) }.sort_by(&:name).each do |tag|
      new_tags = {}
      new_tags[:tags] = param_tags + [tag.name]
      new_params = h_params.except(:controller, :action, :tags).merge(new_tags)
      output << "<li><a href=\"#{polymorphic_path(model, new_params)}\">#{tag.name} <span>#{model.tagged_with(tag).length}</span></a></li>"
    end
    output << "</ul>"
    output.html_safe
  end
end
