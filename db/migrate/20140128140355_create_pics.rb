class CreatePics < ActiveRecord::Migration
  def up
    create_table :pics do |t|
      t.boolean :published
      t.string :title
      t.string :permalink
      t.attachment :attachment
      t.text :caption
      t.string :token
      t.string :sent_by

      t.timestamps
    end
  end

  def down
    drop_table :pics
  end
end
