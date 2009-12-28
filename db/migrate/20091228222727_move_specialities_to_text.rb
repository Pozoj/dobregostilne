class MoveSpecialitiesToText < ActiveRecord::Migration
  def self.up
    change_column :spot_infos, :speciality, :text
  end

  def self.down
    change_column :spot_infos, :speciality, :string
  end
end
