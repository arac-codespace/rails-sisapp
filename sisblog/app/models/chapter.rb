class Chapter < ActiveRecord::Base
    
    include PublicActivity::Common

    belongs_to :project
    
    # def previous_post
    #   self.class.first(:conditions => ["id < ?", id], :order => "id desc")
    # end
    
    # def next_post
    #     Chapter.where(["id > ?", :id]).order(id: :desc).first
    # end    

end