class CreateDramas < ActiveRecord::Migration[5.0]
  def change
    create_table :dramas do |t|
      t.string :title
      t.string :category
      t.string :actors
      t.date :release_date
      t.string :drama_description
      t.string :comments
      t.timestamps
    end
  end
end
