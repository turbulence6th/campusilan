require 'test_helper'

class UserControllerTest < ActionController::TestCase
 
  test "check valid username" do
    post :checkusername,  :username => 'username2' , :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal true, body['check']
  end
  
  test "check invalid username" do
    post :checkusername,  :username => 'username2+' , :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal false, body['check']
  end
  
  test "check used username" do
    post :checkusername,  :username => 'turbulence6th' , :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal false, body['check']
  end

end
