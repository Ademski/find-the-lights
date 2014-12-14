class AddPhotoColumnToDisplayImages < ActiveRecord::Migration
  def change
    add_attachment :display_images, :photo
  end
end
