require File.dirname(__FILE__) + '/../test_helper'
require 'spot_infos_controller'

# Re-raise errors caught by the controller.
class SpotInfosController; def rescue_action(e) raise e end; end

class SpotInfosControllerTest < Test::Unit::TestCase
  fixtures :spot_infos

  def setup
    @controller = SpotInfosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:spot_infos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_spot_info
    old_count = SpotInfo.count
    post :create, :spot_info => { }
    assert_equal old_count+1, SpotInfo.count
    
    assert_redirected_to spot_info_path(assigns(:spot_info))
  end

  def test_should_show_spot_info
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_spot_info
    put :update, :id => 1, :spot_info => { }
    assert_redirected_to spot_info_path(assigns(:spot_info))
  end
  
  def test_should_destroy_spot_info
    old_count = SpotInfo.count
    delete :destroy, :id => 1
    assert_equal old_count-1, SpotInfo.count
    
    assert_redirected_to spot_infos_path
  end
end
