class CreateDisplayImages < ActiveRecord::Migration
  def change
    create_table :display_images do |t|
      t.string :caption
      t.belongs_to :light_display, index: true

      t.timestamps
    end
  end
end
