class AddTimestampsToChapter < ActiveRecord::Migration[5.0]
  def change
    add_column :chapters, :created_at, :datetime
    add_column :chapters, :updated_at, :datetime
  end
end
