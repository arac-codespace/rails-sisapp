class CreateChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters do |t|
      t.integer :projects_id
      t.string :chapter_number
      t.string :chapter_text
    end
  end
end
