class LightDisplaysController < ApplicationController
  before_action :set_light_display, only: [:show, :edit, :update, :destroy]

  respond_to :html

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
    
    respond_to do |format|
      if @light_display.save
        if params[:images]
          params[:images].each { |image| 
            @light_display.display_images.create(photo: image)
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
      params.require(:light_display).permit(:name, :description)
    end
end
