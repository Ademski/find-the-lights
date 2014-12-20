class LightDisplay < ActiveRecord::Base
  has_many :display_images, :inverse_of => :light_display, :dependent => :destroy
  belongs_to :user
  
  geocoded_by :address
  before_validation :geocode
  
  validates :latitude, :longitude, :presence => { :message => "Address is not valid" }
  validates :display_images, :presence => { :message => "Please attach an image" }

  # enable nested attributes for photos through album class
  accepts_nested_attributes_for :display_images, allow_destroy: true
  
  def top_image
    self.display_images.last
  end
  
  def formatted_user
    self.user ? self.user.name : 'Unknown'
  end
  
end
