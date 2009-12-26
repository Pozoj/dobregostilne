class SpotsController < ResourceController::Base
  belongs_to :locality
  
  create.before do
    I18n.available_locales.each do |l|
      @spot.spot_infos.build(:language => l.to_s)
    end  
  end
end
