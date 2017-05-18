class Chapter < ActiveRecord::Base
  
  belongs_to :project

  include PublicActivity::Common

  
  def to_param
    "#{self.id} #{self.chapter_number}".parameterize
  end



end