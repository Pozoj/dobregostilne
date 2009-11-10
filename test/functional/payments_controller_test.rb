require File.dirname(__FILE__) + '/../test_helper'
require 'payments_controller'

# Re-raise errors caught by the controller.
class PaymentsController; def rescue_action(e) raise e end; end

class PaymentsControllerTest < Test::Unit::TestCase
  fixtures :payments

  def setup
    @controller = PaymentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:payments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_payment
    old_count = Payment.count
    post :create, :payment => { }
    assert_equal old_count+1, Payment.count
    
    assert_redirected_to payment_path(assigns(:payment))
  end

  def test_should_show_payment
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_payment
    put :update, :id => 1, :payment => { }
    assert_redirected_to payment_path(assigns(:payment))
  end
  
  def test_should_destroy_payment
    old_count = Payment.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Payment.count
    
    assert_redirected_to payments_path
  end
end
