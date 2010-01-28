class SpotsController < ResourceController::Base
  create.before do
    I18n.available_locales.each do |l|
      @spot.spot_infos.build(:language => l.to_s)
    end  
  end
  
  update.before do
    params[:spot][:payment_ids] ||= []
  end
  
  def collection
    if params[:post_id]
      @post = Post.find params[:post_id]
      @spots = @post.spots
    elsif params[:locality_id]
      @locality = Locality.find params[:locality_id]
      @spots_grouped = @locality.spots.group_by { |s| s.post }
      @spots = @locality.spots
    else
      @spots = Spot.all
    end
  end
end
