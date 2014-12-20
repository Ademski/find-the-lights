# app/models/geocode_request.rb
class GeocodeRequest
  def initialize(request)
    @request = request
  end

  def current_location
    if city.empty? || state.empty?
      nil
    else
      Location.new(
        :address => ([city, state].join ','),
        :latitude => latitude,
        :longitude => longitude
        )
    end
  end
  
  private
    delegate :city, :state, :longitude, :latitude, to: :location
    delegate :location, to: :@request
end