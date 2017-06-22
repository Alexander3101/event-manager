require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get personal" do
    get users_personal_url
    assert_response :success
  end

end
