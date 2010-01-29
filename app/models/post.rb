class Post < ActiveRecord::Base
  default_scope :order => "name"
  has_many :spots
  
  def self.find_with_spots
    Spot.all.map(&:post).uniq
  end
  
  def to_s
    name
  end
end
