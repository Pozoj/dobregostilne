class Payment < ActiveRecord::Base
  has_and_belongs_to_many :spots
  
  def icon
    "payments/#{name.make_file_system_friendly}.png"
  end
  
  def to_s
    name
  end
end
