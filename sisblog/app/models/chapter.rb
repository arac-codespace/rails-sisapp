class Chapter < ActiveRecord::Base
    
    include PublicActivity::Common

    belongs_to :project

end