class Spot < ActiveRecord::Base
  belongs_to :post
  belongs_to :type
  belongs_to :locality
  belongs_to :cuisine
  belongs_to :large_post, :class_name => "Post"
  has_and_belongs_to_many :payments
  has_many :images
  has_many :spot_infos, :dependent => :destroy
  
  before_save :geocode, :normalize_uri
  
  def full_address
    "#{street} #{street_number}#{street_number_suffix}" if (!street.blank? and !street_number.blank?)
  end
  
  def geocoded?
   !!(self.lat and self.lng)
  end

  def geocode
   geo = (!street.blank? and !street_number.blank? and post) && Geocoder.geocode(self.full_address, self.post.name, self.post.id)

   if geo
     self.lat, self.lng = geo.lat, geo.lng
   else
     self.lat = self.lng = nil
   end
  end

  def geocode!
   geocode
   save(false)
  end
  
  def spot_info_attributes=(si_attrs)
    si_attrs.each do |attrs|
      spot_infos.build(attrs)
    end
  end
  
  protected
  
  def normalize_uri
    self.website = uri_normalize(self.website)
  end
  
  # Function automatically checks if URI has protocol specified, if not it adds the http.
	def uri_normalize(uri)
  	return 'http://' + uri unless uri =~ /http:\/\//
  	uri
	end
end


