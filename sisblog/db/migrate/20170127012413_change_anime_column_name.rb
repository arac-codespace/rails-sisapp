class ChangeAnimeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :animes, :actors, :studios
  end
end
