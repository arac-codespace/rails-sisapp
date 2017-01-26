class CreateFacialProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :facial_products do |t|
      t.string :title
      t.string :actors
      t.date :release_date
      t.text :facialproduct_description
      t.text :comments
      t.string :rating
      t.timestamps        
    end
  end
end

