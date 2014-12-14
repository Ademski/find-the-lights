class LightDisplay < ActiveRecord::Base
  has_many :display_images, :inverse_of => :light_display, :dependent => :destroy
  # enable nested attributes for photos through album class
  accepts_nested_attributes_for :display_images, allow_destroy: true
  
end
