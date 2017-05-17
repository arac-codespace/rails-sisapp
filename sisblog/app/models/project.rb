class Project < ActiveRecord::Base

  has_many :chapters

  include PublicActivity::Common

  before_create :randomize_id
  

  has_attached_file :avatar, 
                    styles: { medium: "300x300>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/  
  
  
  # Generates an unique id for the object to use for disqus unique id 
  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while Project.where(id: self.id).exists?
  end
  
end