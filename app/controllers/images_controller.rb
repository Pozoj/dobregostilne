class ImagesController < ResourceController::Base
  belongs_to :spot

  create.wants.html { redirect_to @image.spot }
  update.wants.html { redirect_to @image.spot }
  destroy.wants.html { redirect_to @image.spot }
  
  def parent_object
    @spot ||= Spot.find_by_name_websafe params[:spot_id]
  end
  
end
