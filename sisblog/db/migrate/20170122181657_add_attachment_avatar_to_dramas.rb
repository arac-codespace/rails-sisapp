class AddAttachmentAvatarToDramas < ActiveRecord::Migration
  def self.up
    change_table :dramas do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :dramas, :avatar
  end
end
