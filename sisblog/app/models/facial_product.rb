class FacialProduct < ActiveRecord::Base
  include PublicActivity::Common
  
  before_create :randomize_id  
  
  has_attached_file :avatar, 
                    styles: { medium: "300x300>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/  
  
  def to_param
    "#{id} #{title}".parameterize
  end
  
  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(9_999)
    end while FacialProduct.where(id: self.id).exists?
  end  
end