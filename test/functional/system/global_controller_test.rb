require 'test_helper'

class System::GlobalControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
