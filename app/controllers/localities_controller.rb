class LocalitiesController < ResourceController::Base
  create.wants.html { redirect_to locality_spots_path(@locality) }
  update.wants.html { redirect_to locality_spots_path(@locality) }
end
