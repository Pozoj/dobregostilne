class ImagesController < ResourceController::Base
  belongs_to :spot

  create.wants.html { redirect_to @image.spot }
  update.wants.html { redirect_to @image.spot }
  destroy.wants.html { redirect_to @image.spot }
  
end
