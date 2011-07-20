class AddVisibleUntilToSpots < ActiveRecord::Migration
  def self.up
    add_column :spots, :visible_until, :date
  end

  def self.down
    remove_column :spots, :visible_until
  end
end
