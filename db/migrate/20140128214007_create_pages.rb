class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.text :content
      t.text :javascript

      t.timestamps
    end
  end
end
