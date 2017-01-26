class CreateCares < ActiveRecord::Migration[5.0]
  def change
    create_table :cares do |t|
      t.string :title
      t.string :category
      t.text :care_description
      t.text :comments
      t.timestamps      
    end
  end
end
