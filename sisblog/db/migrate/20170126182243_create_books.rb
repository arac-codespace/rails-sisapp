class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :actors
      t.date :release_date
      t.text :book_description
      t.text :comments
      t.string :rating
      t.timestamps      
    end
  end
end