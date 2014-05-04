class DropDeprecatedFromPics < ActiveRecord::Migration
  def up

    remove_column :pics, :camera_model
    remove_column :pics, :date_taken

    #reprocess the pics to apply updated behaviour
    Pic.all.each do |pic|
      pic.attachment.reprocess!
      sleep 3 #don't piss off the geocoding server
    end

  end
end
