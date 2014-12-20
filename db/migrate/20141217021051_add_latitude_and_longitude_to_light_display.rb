class AddLatitudeAndLongitudeToLightDisplay < ActiveRecord::Migration
  def change
    add_column :light_displays, :latitude, :float
    add_column :light_displays, :longitude, :float
  end
end
