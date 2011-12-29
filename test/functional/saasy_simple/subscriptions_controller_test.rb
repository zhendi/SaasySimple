require 'test_helper'

module SaasySimple
  class SubscriptionsControllerTest < ActionController::TestCase
    test "should get activate" do
      get :activate
      assert_response :success
    end
  
    test "should get billing" do
      get :billing
      assert_response :success
    end
  
    test "should get deactivate" do
      get :deactivate
      assert_response :success
    end
  
  end
end
