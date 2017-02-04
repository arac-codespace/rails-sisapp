class AddAttachmentAvatarToRecommendations < ActiveRecord::Migration
  def self.up
    change_table :recommendations do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :recommendations, :avatar
  end
end
