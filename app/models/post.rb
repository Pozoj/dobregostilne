class Post < ActiveRecord::Base
  default_scope :order => "name"
end
