require 'test_helper'

class PluginsControllerTest < ActionController::TestCase
  test "should get toolbar" do
    get :toolbar
    assert_response :success
  end

end
