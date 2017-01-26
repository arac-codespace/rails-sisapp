class AddAttachmentAvatarToOthers < ActiveRecord::Migration
  def self.up
    change_table :others do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :others, :avatar
  end
end
