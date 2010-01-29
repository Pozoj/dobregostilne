class PostsController < ResourceController::Base
  create.wants.html { redirect_to collection_url }
  update.wants.html { redirect_to collection_url }  
  
  def collection
    @posts ||= Post.find_with_spots
  end
end
