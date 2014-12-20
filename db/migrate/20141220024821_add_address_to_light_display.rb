class AddAddressToLightDisplay < ActiveRecord::Migration
  def change
    add_column :light_displays, :address, :string
  end
end
