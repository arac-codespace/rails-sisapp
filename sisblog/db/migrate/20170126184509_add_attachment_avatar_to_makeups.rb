class AddAttachmentAvatarToMakeups < ActiveRecord::Migration
  def self.up
    change_table :makeups do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :makeups, :avatar
  end
end
