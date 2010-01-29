class Payment < ActiveRecord::Base
  has_and_belongs_to_many :spots
  
  def icon
    "icons/cc/#{name.make_file_system_friendly}.gif"
  end
  
  def to_s
    name
  end
end
