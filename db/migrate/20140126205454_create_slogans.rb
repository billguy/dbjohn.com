class CreateSlogans < ActiveRecord::Migration
  def change
    create_table :slogans do |t|
      t.boolean :active
      t.string :title

      t.timestamps
    end
  end
end
