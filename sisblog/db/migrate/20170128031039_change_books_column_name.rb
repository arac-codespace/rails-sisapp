class ChangeBooksColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :books, :actors, :author  
  end
end
