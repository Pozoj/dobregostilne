class CreateSpotInfos < ActiveRecord::Migration
  def self.up
    create_table :spot_infos, :force => true do |t|
      t.string :working_hours
      t.string :closed
      t.text :location_description
      t.string :speciality
      t.text :spoon_dishes
      t.text :description
      t.text :wellness_description
      t.text :equipment_description
      t.text :extra_description
      t.string :language
      t.integer :spot_id

      t.timestamps
    end
  end

  def self.down
    drop_table :spot_infos
  end
end
