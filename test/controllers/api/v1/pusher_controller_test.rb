require 'test_helper'

class Api::V1::PusherControllerTest < ActionController::TestCase
  test "should get auth" do
    get :auth
    assert_response :success
  end

end
