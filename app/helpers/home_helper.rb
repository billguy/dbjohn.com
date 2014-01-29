module HomeHelper

  def caption(pic)
    date = pic.date_taken || pic.updated_at
    pic_date = date.strftime("%a, %b %e, %Y %l:%M%p")
    location = pic.location
    model = pic.camera_model
    taken_with = location && model ? "Taken with a #{pic.camera_model} near #{location}<br/>" : nil
    raw "#{pic_date}<br/>#{taken_with} #{pic.caption}"
  end
end
