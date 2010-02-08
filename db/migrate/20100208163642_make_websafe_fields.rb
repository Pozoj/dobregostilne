class MakeWebsafeFields < ActiveRecord::Migration
  def self.up
    Spot.all.each do |s|
      s.save
    end
  end

  def self.down
    Spot.update_all(:name_websafe => nil)
  end
end
