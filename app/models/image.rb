class Image < ActiveRecord::Base
  belongs_to :spot
  has_attached_file :image, :styles => { :mini => "50x50#", :square => "75x75#", :small => "150x150", :medium => "320x320>", :normal => "550x550>" },
                    :url  => "/assets/spots/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/spots/:id/:style/:basename.:extension"
end
