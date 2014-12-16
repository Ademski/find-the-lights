class AddUserToDisplayImage < ActiveRecord::Migration
  def change
    add_reference :display_images, :user, index: true
  end
end
