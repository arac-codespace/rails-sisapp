class CreateMakeups < ActiveRecord::Migration[5.0]
  def change
    create_table :makeups do |t|
      t.string :title
      t.string :actors
      t.date :release_date
      t.text :makeup_description
      t.text :comments
      t.string :rating
      t.timestamps        
    end
  end
end
