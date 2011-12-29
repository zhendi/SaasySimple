require 'test_helper'

module SaasySimple
  class SubscriptionsControllerTest < ActionController::TestCase
    test "should post activate" do
      post "subscriptions/activate"
      assert_response :success
    end
  
    test "should get billing" do
      get  "/saasysimple/subscriptions/billing"
      assert_response :success
    end
  
    test "should get deactivate" do
      post "/saasysimple/subscriptions/deactivate"
      assert_response :success
    end
  end
end
