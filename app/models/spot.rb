class Spot < ActiveRecord::Base
  belongs_to :post
  belongs_to :type
  belongs_to :locality
  belongs_to :cuisine
  belongs_to :large_post, :class_name => "Post"
  has_and_belongs_to_many :payments
  has_many :images
  has_many :spot_infos, :dependent => :destroy
  accepts_nested_attributes_for :payments
  before_save :geocode, :normalize_uri, :make_websafe
  default_scope :order => "name"
  named_scope :geocoded, :conditions => "lng IS NOT NULL AND lat IS NOT NULL"
  
  has_a_location
  
  # def to_param
  #   name_websafe
  # end
  
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
  
  def images_other
    return [] if images.size < 2
    images[1..(images.size)]
  end
  
  def to_s
    name
  end
  
  protected
  
  def normalize_uri
    self.website = uri_normalize(website)
  end
    
  def make_websafe
    self.name_websafe = name.make_websafe
  end
  
  # Function automatically checks if URI has protocol specified, if not it adds the http.
	def uri_normalize(uri)
  	return 'http://' + uri unless uri =~ /http:\/\//
  	uri
	end
end


