class CreateBlogs < ActiveRecord::Migration
  def up
    create_table :blogs do |t|
      t.boolean :published
      t.string :title
      t.string :permalink
      t.text :content
      t.text :javascript

      t.timestamps
    end
  end

  def down
    drop_table :blogs
  end
end
