class SpotInfosController < ResourceController::Base
  belongs_to :spot
  
  protected
  
  def parent_object
    @spot ||= Spot.find_by_name_websafe params[:spot_id]
  end
end
