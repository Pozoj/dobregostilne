class Post < ActiveRecord::Base
  default_scope :order => "name"
  has_many :spots
  
  def to_s
    name
  end
end
