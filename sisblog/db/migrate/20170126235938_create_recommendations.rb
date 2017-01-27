class CreateRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :recommendations do |t|
      t.string :title
      t.string :category
      t.text :recommendation_description
      t.text :comments
      t.timestamps          
    end
  end
end
