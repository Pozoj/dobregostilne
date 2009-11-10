require File.dirname(__FILE__) + '/../test_helper'
require 'localities_controller'

# Re-raise errors caught by the controller.
class LocalitiesController; def rescue_action(e) raise e end; end

class LocalitiesControllerTest < Test::Unit::TestCase
  fixtures :localities

  def setup
    @controller = LocalitiesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:localities)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_locality
    old_count = Locality.count
    post :create, :locality => { }
    assert_equal old_count+1, Locality.count
    
    assert_redirected_to locality_path(assigns(:locality))
  end

  def test_should_show_locality
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_locality
    put :update, :id => 1, :locality => { }
    assert_redirected_to locality_path(assigns(:locality))
  end
  
  def test_should_destroy_locality
    old_count = Locality.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Locality.count
    
    assert_redirected_to localities_path
  end
end
