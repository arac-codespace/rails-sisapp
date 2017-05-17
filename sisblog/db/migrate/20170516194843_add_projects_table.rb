class AddProjectsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :category
      t.text :project_description
      t.text :comments
      t.string :rating
      t.timestamps
    end
  end
end
