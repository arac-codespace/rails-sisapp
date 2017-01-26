class AddAttachmentAvatarToAnimes < ActiveRecord::Migration
  def self.up
    change_table :animes do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :animes, :avatar
  end
end
