class AddAttachmentAvatarToCrafts < ActiveRecord::Migration
  def self.up
    change_table :crafts do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :crafts, :avatar
  end
end
