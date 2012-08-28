require 'test_helper'

class System::AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get regen" do
    get :regen
    assert_response :success
  end

end
