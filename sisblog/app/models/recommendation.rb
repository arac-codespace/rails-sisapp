class Recommendation < ActiveRecord::Base
  include PublicActivity::Common
  
  before_create :randomize_id
  
  # Generates an unique id for the object to use for disqus unique id 
  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while Recommendation.where(id: self.id).exists?
  end
  
end