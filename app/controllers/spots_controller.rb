class SpotsController < ResourceController::Base
  before_filter :load_parents
  
  show.after do
    @spot_info = object.spot_infos.find_by_language(current_locale)
  end
  
  create.before do
    @spot.locality = @locality if @locality
    I18n.available_locales.each do |l|
      @spot.spot_infos.build(:language => l.to_s)
    end  
  end
  
  update.before do
    params[:spot][:payment_ids] ||= []
  end
  
  protected
  
  def load_parents
    if params[:post_id]
      @post = Post.find params[:post_id]
    elsif params[:locality_id]
      @locality = Locality.find params[:locality_id]
    end
  end
  
  def object
    @spot ||= Spot.find_by_name_websafe params[:id]
  end
  
  def collection
    if @post
      @spots = @post.spots
    elsif @locality 
      @spots_grouped = @locality.spots.group_by { |s| s.post }
      @spots = @locality.spots
    else
      @spots = Spot.all
    end
  end
end
