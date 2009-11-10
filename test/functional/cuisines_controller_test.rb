require File.dirname(__FILE__) + '/../test_helper'
require 'cuisines_controller'

# Re-raise errors caught by the controller.
class CuisinesController; def rescue_action(e) raise e end; end

class CuisinesControllerTest < Test::Unit::TestCase
  fixtures :cuisines

  def setup
    @controller = CuisinesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:cuisines)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_cuisine
    old_count = Cuisine.count
    post :create, :cuisine => { }
    assert_equal old_count+1, Cuisine.count
    
    assert_redirected_to cuisine_path(assigns(:cuisine))
  end

  def test_should_show_cuisine
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_cuisine
    put :update, :id => 1, :cuisine => { }
    assert_redirected_to cuisine_path(assigns(:cuisine))
  end
  
  def test_should_destroy_cuisine
    old_count = Cuisine.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Cuisine.count
    
    assert_redirected_to cuisines_path
  end
end
