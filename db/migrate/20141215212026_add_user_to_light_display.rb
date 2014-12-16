class AddUserToLightDisplay < ActiveRecord::Migration
  def change
    add_reference :light_displays, :user, index: true
  end
end
