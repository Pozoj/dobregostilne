require File.dirname(__FILE__) + '/../test_helper'
require 'types_controller'

# Re-raise errors caught by the controller.
class TypesController; def rescue_action(e) raise e end; end

class TypesControllerTest < Test::Unit::TestCase
  fixtures :types

  def setup
    @controller = TypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_type
    old_count = Type.count
    post :create, :type => { }
    assert_equal old_count+1, Type.count
    
    assert_redirected_to type_path(assigns(:type))
  end

  def test_should_show_type
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_type
    put :update, :id => 1, :type => { }
    assert_redirected_to type_path(assigns(:type))
  end
  
  def test_should_destroy_type
    old_count = Type.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Type.count
    
    assert_redirected_to types_path
  end
end
