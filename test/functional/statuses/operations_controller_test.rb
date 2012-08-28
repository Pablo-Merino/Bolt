require 'test_helper'

class Statuses::OperationsControllerTest < ActionController::TestCase
  test "should get favorite" do
    get :favorite
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
