# app/models/location.rb
class Location
  
  attr_accessor :address, :latitude, :longitude

  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end