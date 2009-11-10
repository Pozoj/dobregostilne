require File.dirname(__FILE__) + '/../test_helper'
require 'spots_controller'

# Re-raise errors caught by the controller.
class SpotsController; def rescue_action(e) raise e end; end

class SpotsControllerTest < Test::Unit::TestCase
  fixtures :spots

  def setup
    @controller = SpotsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:spots)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_spot
    old_count = Spot.count
    post :create, :spot => { }
    assert_equal old_count+1, Spot.count
    
    assert_redirected_to spot_path(assigns(:spot))
  end

  def test_should_show_spot
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_spot
    put :update, :id => 1, :spot => { }
    assert_redirected_to spot_path(assigns(:spot))
  end
  
  def test_should_destroy_spot
    old_count = Spot.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Spot.count
    
    assert_redirected_to spots_path
  end
end
