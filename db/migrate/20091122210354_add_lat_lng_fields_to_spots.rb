class AddLatLngFieldsToSpots < ActiveRecord::Migration
  def self.up
    add_column :spots, :lat, :float
    add_column :spots, :lng, :float
  end

  def self.down
    remove_column :spots, :lng
    remove_column :spots, :lat
  end
end
