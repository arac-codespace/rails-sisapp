class CreateCrafts < ActiveRecord::Migration[5.0]
  def change
    create_table :crafts do |t|
      t.string :title
      t.text :craft_description
      t.text :comments
      t.timestamps      
    end
  end
end
