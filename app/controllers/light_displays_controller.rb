class LightDisplaysController < ApplicationController
  before_action :set_light_display, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :store_last_url, only: [:new, :edit]

  respond_to :html
  
  class_attribute :geocode_request 
  self.geocode_request = GeocodeRequest

  def index
    @current_location = current_location
    logger.info "current location: #{@current_location.to_s}\n"
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
      if @light_display.save
        if params[:images]
          params[:images].each { |image| 
            @light_display.display_images.create(photo: image, user: current_user)
          }
        end
        
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
      if !(params[:search]=="")
        params[:search] && params[:search][:value]
      elsif geocode_request.new(request).current_location
        geocode_request.new(request).current_location
      else
        "Acton, MA"
      end
    end
    
    def search_string
      params[:search] && params[:search][:value]
    end
      
end
