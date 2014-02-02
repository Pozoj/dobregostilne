# uses:
# - Location.geocode_address
# - GeoKit::Geocoders::YahooGeocoder.geocode, GoogleGeocoder
module Geocoder
  extend self
  
  def geocode(spot_or_street, city = nil, zip = nil)
    street = spot_or_street
    street, city = street.split(/,\s*/, 2) if city.nil? and street.index(',')
    raise ArgumentError unless city

    address = normalize_address(street, city, zip)
    remote_geocoding(address, :google)
  end
  

  private
  
  def normalize_address(street, city, zip)
    geo_street = street.gsub /ul\./, "ulica"
    geo_street = geo_street.gsub /c\./, "cesta"
    city = "#{zip} #{city}" if zip
    [geo_street, city, 'Slovenia'].select { |word| !word.blank? }.map { |word| word.force_encoding('utf-8') }.join(', ')
  end
  
  def remote_geocoding(address, provider)
    result = Geokit::Geocoders::GoogleGeocoder3.geocode(address)
    return result if result.success
  end
end
