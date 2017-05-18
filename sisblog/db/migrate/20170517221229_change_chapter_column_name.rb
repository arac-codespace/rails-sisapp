class ChangeChapterColumnName < ActiveRecord::Migration[5.0]
  def change
    
    rename_column :chapters, :projects_id, :project_id
    
  end
end
