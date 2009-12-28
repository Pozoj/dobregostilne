class ImagesController < ResourceController::Base
  belongs_to :spot

  create.wants.html { redirect_to @spot }
  update.wants.html { redirect_to @spot }
  destroy.wants.html { redirect_to @spot }
  
end
