class Image < ActiveRecord::Base
  belongs_to :spot
  has_attached_file :image, :styles => { :mini => "50x50#", :square => "75x75#", :small => "150x150", :medium => "320x320>", :normal => "550x550>" },
                    :path  => "/assets/spots/:id/:style/:basename.:extension",
                    :whiny => false,
                    :storage => :s3,
                    :bucket => ENV['AWS_BUCKET'],
                    :s3_credentials => {
                      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                    }
  
  def name
    File.basename image.url
  end
end
