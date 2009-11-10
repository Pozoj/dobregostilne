class Spot < ActiveRecord::Base
  belongs_to :post
  belongs_to :type
  belongs_to :locality
  belongs_to :cuisine
  belongs_to :large_post, :class_name => "Post"
  has_and_belongs_to_many :payments
  has_many :images
  has_many :spot_infos
end
