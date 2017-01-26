class CreateAnimes < ActiveRecord::Migration[5.0]
  def change
    create_table :animes do |t|
      t.string :title
      t.string :actors
      t.date :release_date
      t.text :anime_description
      t.text :comments
      t.string :rating
      t.timestamps
    end
  end
end
