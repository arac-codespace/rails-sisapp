class AddAttachmentAvatarToFacialProducts < ActiveRecord::Migration
  def self.up
    change_table :facial_products do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :facial_products, :avatar
  end
end
