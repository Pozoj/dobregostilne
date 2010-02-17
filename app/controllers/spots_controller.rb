class SpotsController < ResourceController::Base
  def in_area
    if params[:zoom] and params[:center_x] and params[:center_y]
      @spots = Spot.on_map [params[:center_y].to_f, params[:center_x].to_f], [700, 350], params[:zoom].to_i
    end
    render :layout => false if request.xhr?
  end
  
  def search
    @spots = Spot.geocoded.search params[:terms]
    render :layout => false
  end
  
  show.before do
    @spot_info = object.spot_infos.find_by_language(current_locale)
    @nearby = @spot.in_radius(10)
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
  
  def object
    @spot ||= Spot.find_by_name_websafe params[:id]
  end
  
end
