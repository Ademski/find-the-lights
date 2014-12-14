class CreateLightDisplays < ActiveRecord::Migration
  def change
    create_table :light_displays do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
