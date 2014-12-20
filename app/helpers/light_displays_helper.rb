module LightDisplaysHelper
  def current_location_address
    @current_location ? @current_location.address : ""
  end 
end
