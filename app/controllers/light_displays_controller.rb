class LightDisplaysController < ApplicationController
  before_action :set_light_display, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :store_last_url, only: [:new, :edit]
  before_action :set_current_location, only: [:new, :index]

  respond_to :html
  
  class_attribute :geocode_request 
  self.geocode_request = GeocodeRequest

  def index
    @light_displays = LightDisplay.all
    respond_with(@light_displays)
  end

  def show
    respond_with(@light_display)
  end

  def new
    @light_display = LightDisplay.new
    respond_with(@light_display)
  end

  def edit
  end

  def create
    @light_display = LightDisplay.new(light_display_params)
    @light_display.user = current_user
    
    
    respond_to do |format|
      if params[:images]
        params[:images].each { |image| 
          @light_display.display_images.build(photo: image, user: current_user)
        }
      end
      
      if @light_display.save
        format.html { redirect_to @light_display, notice: 'Light display was successfully created.' }
        format.json { render json: @light_display, status: :created, location: @light_display }
      else
        format.html { render action: "new" }
        format.json { render json: @light_display.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    flash[:notice] = 'LightDisplay was successfully updated.' if @light_display.update(light_display_params)
    respond_with(@light_display)
  end

  def destroy
    @light_display.destroy
    respond_with(@light_display)
  end

  private
    def set_light_display
      @light_display = LightDisplay.find(params[:id])
    end

    def light_display_params
      params.require(:light_display).permit(:name, :description, :address)
    end
    
    def store_last_url
      session[:return_to] ||= request.referer
    end
    
    def current_location
      logger.debug "Request Location: #{request.location.inspect}"
      if !(params[:search].nil?)
        search_geo = Geocoder.search(params[:search] && params[:search][:value])
        logger.debug "Search Geo: #{search_geo}\n"
        @current_location = Location.new( 
          :address => search_geo.first.data["formatted_address"],
          :latitude => search_geo.first.data["geometry"]["location"]["lat"],
          :longitude => search_geo.first.data["geometry"]["location"]["lng"]
        )
      elsif @current_location = geocode_request.new(request).current_location
        logger.debug "current location set to ip location \n"
        logger.debug "IP Location: #{request.location.inspect} \n"
        logger.debug "current location(IP): #{@current_location.inspect}\n"
      else
        @current_location = Location.new( 
          :address => session[:last_known_address],
          :latitude => session[:last_known_latitude],
          :longitude => session[:last_known_longitude]
        )
        logger.debug "current location set to session location \n"
        logger.debug "Session Location: #{@current_location.inspect} \n"
      end
    end
    
    def search_string
      params[:search] && params[:search][:value]
    end
    
    def set_current_location
      if current_location 
        session[:last_known_address] = @current_location.address
        session[:last_known_latitude] = @current_location.latitude
        session[:last_known_longitude] = @current_location.longitude
      end
      logger.debug "current location: #{@current_location.inspect}\n"
      logger.debug "session location: #{session[:current_location].inspect}"
    end
      
end
