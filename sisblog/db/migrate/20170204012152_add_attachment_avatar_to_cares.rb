class AddAttachmentAvatarToCares < ActiveRecord::Migration
  def self.up
    change_table :cares do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :cares, :avatar
  end
end
