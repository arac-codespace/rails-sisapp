class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :category
      t.string :actors
      t.date :release_date
      t.text :movie_description
      t.text :comments
      t.string :rating
      t.timestamps      
    end
  end
end