class PaymentsController < ResourceController::Base
  belongs_to :spot
  create.wants.html { redirect_to collection_url }
  update.wants.html { redirect_to collection_url }  
end
