# app/models/geocode_request.rb
class GeocodeRequest
  def initialize(request)
    @request = request 
  end

  def current_location 
    (city && state) ? ([city, state].join ',') : ""
  end
  
  private
    delegate :city, :state, to: :location
    delegate :location, to: :@request 
end