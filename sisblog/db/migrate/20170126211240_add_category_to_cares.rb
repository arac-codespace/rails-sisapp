class AddCategoryToCares < ActiveRecord::Migration[5.0]
  def change
    add_column :cares, :category, :string
  end
end
