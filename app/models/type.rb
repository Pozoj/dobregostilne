class Type < ActiveRecord::Base
  has_many :spots
  
  def to_s
    name
  end
end
