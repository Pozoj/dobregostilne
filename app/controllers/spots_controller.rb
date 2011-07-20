class SpotsController < ResourceController::Base
  skip_before_filter :authenticate, :only => [:index, :show, :in_area, :search]
  def in_area
    if params[:zoom] and params[:center_x] and params[:center_y]
      @spots = if admin?
        Spot.on_map [params[:center_y].to_f, params[:center_x].to_f], [700, 350], params[:zoom].to_i
      else
        Spot.visible.on_map [params[:center_y].to_f, params[:center_x].to_f], [700, 350], params[:zoom].to_i
      end
    end
    
    if request.xhr?
      render :layout => false 
    end
  end
  
  def search
    return unless params[:terms]
    letter = "A"
    @spots = admin?? Spot.search(params[:terms]) : Spot.visible.search(params[:terms])
    @spots = @spots.map do |spot| 
      break if letter > "Z"
      spot.letter = letter
      letter = letter.next
      spot
    end
    
    if request.xhr?
      respond_to do |wants|
        wants.js { render :layout => false }
        wants.json { render :layout => false }
        wants.html { render :template => "spots/spot_search.html.haml", :layout => false}
      end
    end
  end
  
  def show
    @spot = Spot.find_by_name_websafe(params[:id])
    @spot = Spot.find(params[:id]) unless @spot
    if @spot
      @spot_info = @spot.spot_infos.find_by_language(current_locale)
      @nearby = @spot.in_radius(10)
    elsif 
      render :file => 'public/404.html', :status => 404      
    end
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
    if action_name == 'show'
      @object = end_of_association_chain.find_by_name_websafe(params[:id])
    else
      super
    end
  end
  
  def collection
    @collection ||= admin?? end_of_association_chain.all : end_of_association_chain.visible
  end
  
end
