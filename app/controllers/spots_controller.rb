class SpotsController < ResourceController::Base
  belongs_to :locality
  
  index.before do
    @spots_grouped = @locality.spots.group_by { |s| s.post }
  end
  
  create.before do
    I18n.available_locales.each do |l|
      @spot.spot_infos.build(:language => l.to_s)
    end  
  end
end
