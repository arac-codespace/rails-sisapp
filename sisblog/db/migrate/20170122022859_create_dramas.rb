class CreateDramas < ActiveRecord::Migration[5.0]
  def change
    create_table :dramas do |t|
      t.string :title
      t.string :category
      t.string :actors
      t.date :release_date
      t.text :drama_description
      t.text :comments
      t.string :rating
      t.timestamps
    end
  end
end
