class ChangeMakeupsColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :makeups, :actors, :company  
  end
end
