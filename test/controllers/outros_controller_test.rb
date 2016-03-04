require 'test_helper'

class OutrosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
