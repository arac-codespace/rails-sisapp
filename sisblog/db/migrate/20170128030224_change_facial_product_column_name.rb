class ChangeFacialProductColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :facial_products, :actors, :company
  end
end

